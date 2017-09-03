require './test/test_helper'
require 'ffi'

class NimblerPathTest < Minitest::Test
  def test_method_works
    assert_equal("yay!", NimblerPath.test) 
  end

  def test_chop_basename
    # if path is root, return nil
    assert_equal(nil, NimblerPath.chop_basename("/")) 

    # if path is a file or directory, split on last dir separator
    v1, v2 = NimblerPath.chop_basename("/path/to/dir")
    assert_equal("/path/to/", v1)
    assert_equal("dir", v2) 

    v1, v2 = NimblerPath.chop_basename("/path/to/file.rb")
    assert_equal("/path/to/", v1)
    assert_equal("file.rb", v2) 
  end
end