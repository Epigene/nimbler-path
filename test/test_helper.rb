$LOAD_PATH.unshift(
  File.expand_path('../../lib', __FILE__)
)

require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_filter '/spec/'
end

require "pry"
require 'minitest/autorun'

require 'nimbler_path'