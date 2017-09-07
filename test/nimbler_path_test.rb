require './test/test_helper'
require 'ffi'

class NimblerPathTest < Minitest::Test
  def test_method_works
    assert_equal("yay!", NimblerPath.test) 
  end

  def test_chop_basename
    # if path is root, return nil
    assert_nil(NimblerPath.chop_basename("/")) 

    # if path is absent, return nil
    assert_nil(NimblerPath.chop_basename("")) 

    # if path is a file or directory, split on last dir separator
    v1, v2 = NimblerPath.chop_basename("/path/to/ā")
    assert_equal("/path/to/", v1)
    assert_equal("ā", v2) 

    # if path is a directory with trailing slash, split on last dir separator
    v1, v2 = NimblerPath.chop_basename("/path/tī/ā/")
    assert_equal("/path/tī/", v1)
    assert_equal("ā", v2) 
  end

  def test_absolute
    # It returns +true+ if the pathname begins with a slash.
  
    assert_equal(
      true,
      NimblerPath.absolute('/im/sure')
    )
  
    assert_equal(
      false,
      NimblerPath.absolute('not/so/sure')
    )
  end
  
  def test_relative
    # It returns +false+ if the pathname begins with a slash.
  
    assert_equal(
      false,
      NimblerPath.relative('/im/sure')
    )
    
    assert_equal(
      true,
      NimblerPath.relative('not/so/sure')
    )
  end

  def test_p
    # Appends a pathname fragment to +self+ to produce a new Pathname object.
    #
    #   p1 = Pathname.new("/usr")      # Pathname:/usr
    #   p2 = p1 + "bin/ruby"           # Pathname:/usr/bin/ruby
    #   p3 = p1 + "/etc/passwd"        # Pathname:/etc/passwd

    assert_equal(
      Pathname.new("/usr/bin/ruby"),
      NimblerPath.p('/usr', 'bin/ruby')
    )

    assert_equal(
      Pathname.new("/etc/passwd"),
      NimblerPath.p('/usr', "/etc/passwd")
    )
  
    assert_equal(
      Pathname.new("/etc/passwd"),
      NimblerPath.p("/usr/", '/etc/passwd')
    )    
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
    assert_equal("./usr/somč/dā/īle.rb", NimblerPath.plus("./usr/somč/other", "../dā/īle.rb"))  

    # correctly parses several leading .. in second arg to cut the end of first
    assert_equal("usr/dir/file.rb", NimblerPath.plus("usr/some/other", "../../dir/file.rb")) 

    # correctly parses several leading .. in second arg to cut all of first
    assert_equal("..", NimblerPath.plus("usr/file.rb", "../../..")) 
  end

  def test_join
    # Joins the given pathnames onto +self+ to create a new Pathname object.
    #
    #   path0 = Pathname.new("/usr")                # Pathname:/usr
    #   path0 = path0.join("bin/ruby")              # Pathname:/usr/bin/ruby
    #       # is the same as
    #   path1 = Pathname.new("/usr") + "bin/ruby"   # Pathname:/usr/bin/ruby
    #   path0 == path1
    #       #=> true

    # no args
    assert_equal(
      Pathname.new("usr"),
      NimblerPath.join(
        Pathname.new("usr")
      )
    )
    
    # non-terminating args
    assert_equal(
      Pathname.new("usr/a/b/c"),
      NimblerPath.join(
        Pathname.new("usr"),
        "a", "b", "c"
      )
    )
    
    # terminating args
    assert_equal(Pathname.new("/b/c/"), NimblerPath.join(Pathname.new("usrc"), "a/.", "/b/", "c/"))    
  end
end

