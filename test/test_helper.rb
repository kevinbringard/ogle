Bundler.setup :default, :test

%w(minitest/spec ogle vcr webmock).each { |r| require r }

TEST_ROOT = File.dirname File.expand_path __FILE__

class MiniTest::Unit::TestCase
  METADATA_KEYS = %w(
    name
    container_format
    disk_format
    checksum
    id
    size
  )

  DETAILED_METADATA_KEYS = %w(
    status
    name
    deleted
    container_format
    created_at
    disk_format
    updated_at
    id
    location
    checksum
    is_public
    deleted_at
    properties
    size
  )
end

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir     = "test/cassettes"
  c.default_cassette_options = { :record => :none }
end

MiniTest::Unit.autorun
