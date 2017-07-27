source 'https://rubygems.org' do
  gemspec
  group :test do
    gem 'coveralls', require: false
  end
end

begin
# https://github.com/ruby/spec dependencies
  eval_gemfile File.expand_path('spec/ruby_spec/Gemfile', File.dirname(__FILE__))
rescue
  `git submodule update --init`
  eval_gemfile File.expand_path('spec/ruby_spec/Gemfile', File.dirname(__FILE__))
end
