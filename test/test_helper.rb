Bundler.setup :default, :test

%w(minitest/spec ogle vcr webmock).each { |r| require r }

class MiniTest::Unit::TestCase
end

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir     = "test/cassettes"
  c.default_cassette_options = { :record => :none }
end

MiniTest::Unit.autorun
