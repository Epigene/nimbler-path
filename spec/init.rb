ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path('../lib', File.dirname(__FILE__))
require 'nimbler_path'
require 'nimbler_path/monkeypatch'
NimblerPath.apply_monkeypatch!
