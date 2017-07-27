# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nimbler_path/version"

Gem::Specification.new do |g|
  g.name          = "nimbler-path"
  g.version       = NimblerPath::VERSION
  g.date          = "2017-07-29"
  g.authors       = ["Epigene"]
  g.email         = ["augusts.bautra@gmail.com"]
  g.required_ruby_version = ['>= 2.1.0', '< 2.5.0']

  g.summary       = %q|Replace File and Path methods with Nim alternatives for speed|
  g.description   = %q|Replace File and Path methods with Nim alternatives for speed|
  g.homepage      = "https://github.com/Epigene/nimbler-path"
  g.license       = "MIT"
  g.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  g.bindir        = "exe"
  g.executables   = g.files.grep(%r{^exe/}) { |f| File.basename(f) }
  g.require_paths = ["lib"]

  g.add_development_dependency "pry"#, "~> 1.15"
  g.add_development_dependency "bundler", "~> 1.15.3"
  g.add_development_dependency "rake", "~> 10.0"
  g.add_development_dependency "rspec", "~> 3.6.0"
end
