Bundler.setup :default, :test

require "ogle"
require "minitest/spec"
require "minitest/autorun"

class MiniTest::Unit::TestCase
  CONNECTION = Ogle::Client.new(
    :host     => "10.1.170.33",
  )
end

MiniTest::Unit.autorun
