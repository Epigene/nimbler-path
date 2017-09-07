require 'pathname'

module NimblerPath
  def self.apply_monkeypatch!(verbose: true)
    Monkeypatch._ruby_library_pathname!
    puts "Replaced some Pathname methods with Nim alternatives!" if verbose
    true
  end

  module Monkeypatch
    def self._ruby_library_pathname!
      ::Pathname.class_eval do

        # Pathname#chop_basename(path) @ https://goo.gl/9Lk1N9 called 24456 times, 25% of execution time alone
        alias_method :old_chop_basename, :chop_basename
        def chop_basename(pth)
          puts ">> In monkeypatched #chop_basename"
          # old_chop_basename(pth)
          NimblerPath.chop_basename(pth, Pathname::SEPARATOR_PAT)
        end
        private :chop_basename

        # Pathname#absolute? @ https://goo.gl/5aXYxw called 4840 times.
        alias_method :old_absolute?, :absolute?
        def absolute?
          puts ">> In monkeypatched #absolute?"
          # old_absolute?
          NimblerPath.absolute?(@path)
        end

        # Pathname#relative? @ https://goo.gl/QK4PCs called ?? times.
        alias_method :old_relative?, :relative?
        def relative?
          puts ">> In monkeypatched #relative?"
          # old_relative?
          NimblerPath.relative?(@path)
        end

        # Pathname#+ @ https://goo.gl/W7biJu called 4606 times.
        alias_method :old_p, :+
        def +(other)
          puts ">> In monkeypatched #+"
          #old_p(other)
          NimblerPath.p(@path, other)
        end

        # Pathname#plus @ https://goo.gl/eRxLYt called 4606 times.
        alias_method :old_plus, :plus
        def plus(path1, path2)
          puts ">> In monkeypatched #plus"          

          #old_plus(path1, path2)
          NimblerPath.plus(path1, path2) # yup, own path is ignored, a dirty implementation
        end

        # Pathname#join @ https://goo.gl/9NzWRt called 4600 times.
        alias_method :old_join, :join
        def join(*args)
          puts ">> In monkeypatched #join"
          # old_join(*args)
          NimblerPath.join(self, *args)
        end

      end
    end
  end

  private_constant :Monkeypatch
end
