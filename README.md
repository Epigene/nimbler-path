# NimblerPath

[![Gem Version](https://img.shields.io/github/tag/Epigene/nimbler-path.svg)](https://github.com/Epigene/nimbler-path/tags)
[![Build Status](https://travis-ci.org/Epigene/nimbler-path.svg?branch=master)](https://travis-ci.org/Epigene/nimbler-path)

This gem replaces most-used Pathname class ruby methods with much faster counterparts written in Nim.  
Use for hassle-free, dependency-free speed gains, primarily in Rails projects.  

## Supported Platforms
As of version 0.9.0 the gem supports 64bit versions of Linux and Mac.  
Support for Windows is a hassle due to differing path separator, among other things.  
Open an issue or PR if other OS support is needed.  

## Dependencies

```ruby
ruby ">= 2.1.10" # for required keyword arguments
```

## Installation

```ruby
gem 'nimbler_path', require: false
```

```ruby
# in an initializer like /config/initializers/nimbler_path.rb
require 'nimbler_path'
require 'nimbler_path/monkeypatch'

NimblerPath.apply_monkeypatch!(verbose: true)
```

## Discussion

[faster_path](https://github.com/danielpclark/faster_path) identifies these Pathname methods as taking the most execution time.

```rb
Pathname#chop_basename(path) @ https://goo.gl/9Lk1N9 called 24456 times, 25% of execution time alone
Pathname#to_s (implicit C definition?) called 29172 times.
Pathname#<=> (implicit C definition?) called 24963 times.
Pathname#initialize in C @ https://goo.gl/dqB8R2 called 23103 times.
Pathname#absolute? @ https://goo.gl/5aXYxw called 4840 times.
Pathname#+ @ https://goo.gl/W7biJu called 4606 times.
Pathname#plus @ https://goo.gl/eRxLYt called 4606 times.
Pathname#join @ https://goo.gl/9NzWRt called 4600 times.
Pathname#extname in C @ https://goo.gl/uANaNu called 4291 times.
Pathname#hash in C @ https://goo.gl/6eVS1x called 4207 times.
Pathname#to_path in C @ https://goo.gl/EX7Cfx called 2706 times.
Pathname#directory? in C @ https://goo.gl/PbMbjY called 2396 times.
Pathname#entries in C @ https://goo.gl/8ALU6R called 966 times.
```

Ignoring methods already implemented in C leaves us with:

```rb
Pathname#chop_basename(path) @ https://goo.gl/9Lk1N9 called 24456 times, 25% of execution time alone

Pathname#+ @ https://goo.gl/W7biJu called 4606 times.
Pathname#plus @ https://goo.gl/eRxLYt called 4606 times.
Pathname#join @ https://goo.gl/9NzWRt called 4600 times.
Pathname#absolute? @ https://goo.gl/5aXYxw called 4840 times.
# flipside
Pathname#relative? @ https://goo.gl/QK4PCs
```

This project, at most, aims to provide performant variants for those six methods.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Epigene/nimbler_path. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

__Development setup__

1. Clone the project with `git clone git@github.com:Epigene/nimbler-path.git`
2. Make sure you are using Ruby v2.1.10
2. Bundle
3. Run naive gem-code tests with `ruby test/nimbler_path_test.rb`
4. Run the tests in included Ruby Spec Suite with `mspec/bin/mspec spec` (Specs affected by this gem are run with `mspec/bin/mspec spec/library/pathname`.
5. Work on feature, commit and make a pull request :clap:
6. See how benchmarks add up with `ruby test/nimbler_path_benchmarks.rb`

Please note that this project includes a snapshot of the [Ruby Spec Suite](https://github.com/ruby/spec/commit/96ba5d539892ed3436cf667d396b10458f95b6d0) project under `spec` and a snapshot of [MSpec project](https://github.com/ruby/mspec/commit/1fa5f7d90503a95712ab378110cba17340269a9d) under `mspec`.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NimblerPath project’s codebases and issue trackers is expected to follow the [code of conduct](https://github.com/Epigene/nimbler_path/blob/master/CODE_OF_CONDUCT.md).

## Inspired By

[faster_path](https://github.com/danielpclark/faster_path)
