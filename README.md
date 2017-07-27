# NimblerPath

[![Gem Version](https://img.shields.io/github/tag/Epigene/nimbler-path.svg)](https://github.com/Epigene/nimbler-path/tags)
[![TravisCI Build Status](https://travis-ci.org/Epigene/nimbler-path.svg?branch=master)](https://travis-ci.org/Epigene/nimbler-path)
[![Coverage Status](https://coveralls.io/repos/github/Epigene/nimbler-path/badge.svg)](https://coveralls.io/github/Epigene/nimbler-path)
[![Code Climate](https://1)](https://1)

This gem replaces most-used Pathname class ruby methods with much faster counterparts written in Nim.  
Use for hassle-free, dependency-free speed gains, primarily in Rails projects.  

## Dependencies

```ruby
ruby ">= 2.1.0" # for required keyword arguments
```

## Installation

```ruby
gem 'nimbler_path'
```

```ruby
# in an initializer like /config/initializers/nimbler_path.rb
NimblerPath.apply_monkeypatch!
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
Pathname#absolute? @ https://goo.gl/5aXYxw called 4840 times.
Pathname#+ @ https://goo.gl/W7biJu called 4606 times.
Pathname#plus @ https://goo.gl/eRxLYt called 4606 times.
Pathname#join @ https://goo.gl/9NzWRt called 4600 times.
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Epigene/nimbler_path. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NimblerPath project’s codebases and issue trackers is expected to follow the [code of conduct](https://github.com/Epigene/nimbler_path/blob/master/CODE_OF_CONDUCT.md).

## Inspired By

[faster_path](https://github.com/danielpclark/faster_path)
