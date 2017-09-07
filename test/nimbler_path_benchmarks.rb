# ruby 
require './test/test_helper'
require 'benchmark'

# #chop_basename
n = 500_000
object = Pathname.new("/")
path = "/path/to/file.rb"
Benchmark.bmbm do |x|
  x.report("Pathname#chop_basename") { n.times { object.send(:chop_basename, path) } }
  x.report("NimblerPath#chop_basename") { n.times { NimblerPath.send(:chop_basename, path) } } 
end; puts

# #absolute?
n = 200_000
path = "/path/to/file.rb"
object = Pathname.new(path)

Benchmark.bmbm do |x|
  x.report("Pathname#absolute?") { n.times { object.absolute? } }
  x.report("NimblerPath#absolute?") { n.times { NimblerPath.absolute?(path) } } 
end; puts

# #relative?
n = 200_000
path = "/path/to/file.rb"
object = Pathname.new(path)

Benchmark.bmbm do |x|
  x.report("Pathname#relative?") { n.times { object.relative? } }
  x.report("NimblerPath#relative?") { n.times { NimblerPath.relative?(path) } } 
end; puts

# #+ aka #p
n = 100_000
s1 = '/usr'
s2 = 'bin/ruby'
object = Pathname.new(s1)

Benchmark.bmbm do |x|
  x.report("Pathname#+") { n.times { object + s2 } }
  x.report("NimblerPath#p") { n.times { NimblerPath.p(s1, s2) } } 
end; puts

# #plus
n = 100_000
s1 = '/usr'
s2 = 'bin/ruby'
object = Pathname.new("/test")

Benchmark.bmbm do |x|
  x.report("Pathname#plus") { n.times { object.send(:plus, s1, s2) } }
  x.report("NimblerPath#plus") { n.times { NimblerPath.plus(s1, s2) } } 
end; puts

# #join
n = 50_000
s1 = '/usr'
s2 = 'bin/ruby'
s3 = 'test.rb'
object = Pathname.new(s1)

Benchmark.bmbm do |x|
  x.report("Pathname#plus") { n.times { object.join(s2, s3) } }
  x.report("NimblerPath#plus") { n.times { NimblerPath.join(object, s2, s3) } } 
end