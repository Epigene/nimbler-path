require "nimbler_path/version"
require 'ffi'

module NimblerPath

  def self.test
    binding.pry
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
  def self.chop_basename(path)
    # NB, besides the obvious :path argument the method receives, Nim implementation must also be provided with the Pathname::SEPARATOR_PAT #=> /\// constant which indicates what path separator is in use on the system.
    # For version 0.9.0, no access to Pathname::SEPARATOR_PAT will be made, avoiding reducing regect o a string, and instead a hardcoded "/" will be passed.

    # binding.pry
    base = File.basename(path) # "/some/path/file.rb" -> "file.rb"
    # Pathname::SEPARATOR_PAT => /\//
    if base[%r'\A/\z'o]
      nil
    else
      return path[0, path.rindex(base)], base
    end
  end

  # Pathname#absolute? @ https://goo.gl/5aXYxw called 4840 times.
  def self.absolute?(path)
    # Nim.is_absolute(path)chop_basename
  end

  # Pathname#+ @ https://goo.gl/W7biJu called 4606 times.
  def self.+(path, other)

  end

  # Pathname#plus @ https://goo.gl/eRxLYt called 4606 times.
  def self.plus(path1, path2)

  end

  # Pathname#join @ https://goo.gl/9NzWRt called 4600 times.
  def self.join(path, *args)
    raise("oops")
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
