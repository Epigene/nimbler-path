require "nimbler_path/version"

module NimblerPath

  # # Spec to Pathname#chop_basename
  # # WARNING! Pathname#chop_basename in STDLIB doesn't handle blank strings correctly!
  # # This implementation correctly handles blank strings just as Pathname had intended
  # # to handle non-path strings.
  # Pathname#chop_basename(path) @ https://goo.gl/9Lk1N9 called 24456 times, 25% of execution time alone
  def self.chop_basename(path, pth)

  end

  # Pathname#absolute? @ https://goo.gl/5aXYxw called 4840 times.
  def self.absolute?(path)
    # Nim.is_absolute(path)
  end

  # Pathname#+ @ https://goo.gl/W7biJu called 4606 times.
  def self.+(path, other)

  end

  # Pathname#plus @ https://goo.gl/eRxLYt called 4606 times.
  def self.plus(path1, path2)

  end

  # Pathname#join @ https://goo.gl/9NzWRt called 4600 times.
  def self.join(path, *args)

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
