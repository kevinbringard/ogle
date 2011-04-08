%w(bundler minitest/spec ogle vcr webmock).each { |r| require r }

Bundler.setup :default, :test

class MiniTest::Unit::TestCase
  def cassette_for cassette
    c = VCR::Cassette.new(cassette).send :recorded_interactions
  end
end

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir      = "test/cassettes"
  c.default_cassette_options  = { :record => :none }
end


MiniTest::Unit.autorun
