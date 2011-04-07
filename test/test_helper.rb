require "bundler"
Bundler.setup :default, :test


%w(minitest/spec minitest/autorun ogle).each { |r| require r }

class MiniTest::Unit::TestCase
  CONNECTION = Ogle::Client.new(
    :host     => "10.1.170.33",
  )
end

MiniTest::Unit.autorun
