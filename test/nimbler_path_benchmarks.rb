# ruby 
require './test/test_helper'
require 'benchmark'

# #chop_basename
n = 1_000_000
object = Pathname.new("/")
path = "/path/to/file.rb"
Benchmark.bmbm do |x|
  x.report("Pathname#chop_basename") { n.times { object.send(:chop_basename, path) } }
  x.report("NimblerPath#chop_basename") { n.times { NimblerPath.send(:chop_basename, path) } } 
end

# #absolute?
n = 1_000
path = "/path/to/file.rb"
object = Pathname.new(path)

Benchmark.bmbm do |x|
  x.report("Pathname#absolute?") { n.times { object.absolute? } }
  x.report("NimblerPath#absolute?") { n.times { NimblerPath.absolute?(path) } } 
end

# #relative?
n = 1_000
path = "/path/to/file.rb"
object = Pathname.new(path)

Benchmark.bmbm do |x|
  x.report("Pathname#relative?") { n.times { object.relative? } }
  x.report("NimblerPath#relative?") { n.times { NimblerPath.relative?(path) } } 
end