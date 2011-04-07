require "bundler"

Bundler.setup :default, :test

%w(minitest/spec ogle).each { |r| require r }

class MiniTest::Unit::TestCase
end

MiniTest::Unit.autorun
