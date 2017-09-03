require './test/test_helper'
require 'ffi'

class NimblerPathTest < Minitest::Test
  def test_method_works
    assert_equal("yay!", NimblerPath.test) 
  end
end