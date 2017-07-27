# NimblerPath

This gem replaces core Ruby file and path methods with much faster counterparts written in Nim.  
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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Epigene/nimbler_path. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NimblerPath project’s codebases and issue trackers is expected to follow the [code of conduct](https://github.com/Epigene/nimbler_path/blob/master/CODE_OF_CONDUCT.md).
