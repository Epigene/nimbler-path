require "nimbler_path/version"
require 'ffi'

module NimblerPath

  def self.test
    # binding.pry
    string = "yay!"
    puts string
    return string
  end

  def self.nim_binary_to_use
    @@nim_binary_to_use ||=
      case ruby_platfrom_string
      when %r'64.*linux'i
        "64-linux"
      when %r'darwin'
        "64-mac"     
      else
        abort("Running on #{ruby_platfrom_string} for which there are no Nim functions included, sorry!") 
      end
  end

  # # Spec to Pathname#chop_basename
  # # WARNING! Pathname#chop_basename in STDLIB doesn't handle blank strings correctly!
  # # This implementation correctly handles blank strings just as Pathname had intended
  # # to handle non-path strings.
  # Pathname#chop_basename(path) @ https://goo.gl/9Lk1N9 called 24456 times, 25% of execution time alone
  def self.chop_basename(path, _separator=nil)
    # The currently unused:_separator arg is usually a /\// regex on Unix systems matching the "/" string
    # NB, besides the obvious :path argument the method receives, Nim implementation must also be provided with the Pathname::SEPARATOR_PAT #=> /\// constant which indicates what path separator is in use on the system.
    # For version 0.9.0, no access to Pathname::SEPARATOR_PAT will be made, avoiding reducing regex to a string, and instead a hardcoded "/" will be passed.

    #binding.pry
    base = File.basename(path) # "/some/path/file.rb" -> "file.rb"
    # Pathname::SEPARATOR_PAT => /\//
    if base[%r'\A/?\z'o]
      nil
    else
      return path[0, path.to_s.rindex(base)], base
    end
  end

  # Pathname#absolute? @ https://goo.gl/5aXYxw called 4840 times.
  def self.absolute(path)
    # Arg must be a String instance

    !relative?(path)
    
    # while r = chop_basename(path)
    #   path, = r
    # end

    # path == ''
  end

  def self.relative(path)
    # Arg must be a String instance

    # while r = chop_basename(path)
    #   path, = r
    # end
    # path == ''
    path[0] != "/"
  end

  # Pathname#+ @ https://goo.gl/W7biJu called 4606 times.
  def self.p(path, other)
    # NB, Nim probably will have a problem with method named "+", use :plus_sign instead
    # :path arg must be a String instance

    Pathname.new(plus(path, other.to_s))
  end

  # Pathname#plus @ https://goo.gl/eRxLYt called 4606 times.
  def self.plus(path1, path2)
    # This is the undocumented source, yuck  
    
    # Both args are definitaly Strings
    
    prefix2 = path2
    index_list2 = []
    basename_list2 = []
    
    # Progressively chops off the end of path2 arg
    # so if path2 was "/etc/passwd" after this loop we will have
    # index_list2 == [1, 5] # denoting that "/"" is 1 and "/etc/" is 5
    # basename_list2 == ["etc", "passwd"]
    while r2 = chop_basename(prefix2) #=> 
      prefix2, basename2 = r2
      index_list2.unshift(prefix2.length) # adds the length(int) to the beginning of index array
      basename_list2.unshift(basename2) # adds the current last bit of path2 to the beginning of basename array
    end          
    
    # returns the second argument given if turns out is absolute
    return path2 if prefix2 != ''

    prefix1 = path1

    while true
      # gets rid of trailing dots from second arg in case of "./dir"
      while !basename_list2.empty? && basename_list2.first == '.'
        index_list2.shift
        basename_list2.shift
      end
      
      # break if first arg is root or empty
      break unless r1 = chop_basename(prefix1)

      prefix1, basename1 = r1
      next if basename1 == '.' # throw away this cut if it's a "/." portion
      
      # recombine if ??
      # So going in prefix1, basename1 = "/", "usr"
      # Going out they get recombined
      if (
        basename1 == '..' ||
        basename_list2.empty? ||
        basename_list2.first != '..'
      )
        prefix1 = prefix1 + basename1
        break
      end

      index_list2.shift
      basename_list2.shift
    end
    # After this fancyness leading .. from second arg have cut the end of first arg

    r1 = chop_basename(prefix1)
    
    # if after cuts first arg is at root or blank AND clean 1st arg has separator pattern in last path element, wut? This never executes!
    if !r1 && /#{Pathname::SEPARATOR_PAT}/o =~ File.basename(prefix1)
      while !basename_list2.empty? && basename_list2.first == '..'
        index_list2.shift
        basename_list2.shift
      end
    end
    
    # final tweaks before return
    if !basename_list2.empty?
      # when there is something in clean 2nd arg
      suffix2 = path2[index_list2.first..-1] # determines the remaining portion of arg2 to append to remaining arg1
      r1 ? File.join(prefix1, suffix2) : (prefix1 + suffix2) # here the diff is basically with arg1 trailing "/" handling
    else
      # when after cleans second arg is absent
      r1 ? prefix1 : File.dirname(prefix1) # File.dirname(prefix1) basically changes "" to "." as final fallback
    end
  end

  # Pathname#join @ https://goo.gl/9NzWRt called 4600 times.
  def self.join(path, args)
    # raise("oops")
    # NB, see how Nim can handle splat arguments. Maybe need to pass in an array

    # :path arg must be a Pathname instance

    return path if args.empty?

    result = args.pop
    result = Pathname.new(result) unless Pathname === result

    return result if result.absolute?

    args.reverse_each {|arg|
      arg = Pathname.new(arg) unless Pathname === arg
      result = arg + result
      return result if result.absolute?
    }
    path + result
  end

  private
  def ruby_platfrom_string
    RUBY_PLATFORM
  end

  module Nim
    # extend FFI::Library
    #
    # attach_function :rust_arch_bits, [], :int32
    # attach_function :is_absolute, [ :string ], :bool

    # EXAMPLE
    # attach_function :one_and_two, [], FromRustArray.by_value
  end
  private_constant :Nim
end
