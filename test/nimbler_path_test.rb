require './test/test_helper'
require 'ffi'

class NimblerPathTest < Minitest::Test
  def test_method_works
    assert_equal("yay!", NimblerPath.test) 
  end

  def test_chop_basename
    # if path is root, return nil
    assert_nil(NimblerPath.chop_basename("/")) 

    # if path is a file or directory, split on last dir separator
    v1, v2 = NimblerPath.chop_basename("/path/to/dir")
    assert_equal("/path/to/", v1)
    assert_equal("dir", v2) 

    # if path is a directory with trailing slash, split on last dir separator
    v1, v2 = NimblerPath.chop_basename("/path/to/dir/")
    assert_equal("/path/to/", v1)
    assert_equal("dir", v2) 

    v1, v2 = NimblerPath.chop_basename("/path/to/file.rb")
    assert_equal("/path/to/", v1)
    assert_equal("file.rb", v2) 
  end

  def test_absolute?
    # It returns +true+ if the pathname begins with a slash.
  
    assert_equal(true, NimblerPath.absolute?('/im/sure'))
  
    assert_equal(false, NimblerPath.absolute?('not/so/sure'))
  end
  
  def test_relative?
    # It returns +false+ if the pathname begins with a slash.
  
    assert_equal(false, NimblerPath.relative?('/im/sure'))
    
    assert_equal(true, NimblerPath.relative?('not/so/sure'))
  end

  def test_p
    # Appends a pathname fragment to +self+ to produce a new Pathname object.
    #
    #   p1 = Pathname.new("/usr")      # Pathname:/usr
    #   p2 = p1 + "bin/ruby"           # Pathname:/usr/bin/ruby
    #   p3 = p1 + "/etc/passwd"        # Pathname:/etc/passwd

    assert_equal(Pathname.new("/usr/bin/ruby"), NimblerPath.p('/usr', 'bin/ruby'))

    assert_equal(Pathname.new("/etc/passwd"), NimblerPath.p('/usr', "/etc/passwd"))
  
    assert_equal(Pathname.new("/etc/passwd"), NimblerPath.p("/usr/", '/etc/passwd'))    
  end

  def test_plus
    # There are no specs, nor comments on this code. Luckily it seems that only the #+ method uses this private method

    assert_equal("/etc/passwd", NimblerPath.plus("/usr/", '/etc/passwd'))
    
    # ignores leading dot on second arg
    assert_equal("/usr/other", NimblerPath.plus("/usr/", './other'))

    # correctly parses .. and . in first arg
    assert_equal("/usr/../src/dir/file.rb", NimblerPath.plus("/usr/../src/.", "dir/file.rb"))    

    # correctly parses leading .. in second arg
    assert_equal("/usr/some/dir/file.rb", NimblerPath.plus("/usr/some/other", "../dir/file.rb"))  

    # correctly parses .. and . in both args
    assert_equal("./usr/some/dir/file.rb", NimblerPath.plus("./usr/some/other", "../dir/file.rb"))  

    # correctly parses several leading .. in second arg to cut the end of first
    assert_equal("usr/dir/file.rb", NimblerPath.plus("usr/some/other", "../../dir/file.rb")) 

    # correctly parses several leading .. in second arg to cut all of first
    assert_equal("..", NimblerPath.plus("usr/file.rb", "../../..")) 
  end
end

