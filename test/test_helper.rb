$LOAD_PATH.unshift(
  File.expand_path('../../lib', __FILE__)
)

require "pry"
require 'minitest/autorun'

require 'nimbler_path'

# optional global monkeypatch
# require 'nimbler_path'
# require 'nimbler_path/monkeypatch'

# NimblerPath.apply_monkeypatch!