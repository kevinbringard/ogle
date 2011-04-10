require "test_helper"

CONNECTION = Ogle::Client.new(
  :host => "10.1.170.33"
)

def assert_valid_keys response, keys
  response.keys.delete_if { |k| keys.include? k }.must_be_empty
end

describe Ogle::Resource do
  describe "#all" do
    before do
      VCR.use_cassette "resource_all" do
        @response = CONNECTION.resource.all
      end
    end

    it "returns a hash of images" do
      @response.size.must_be :>=, 1
    end

    it "returns metadata" do
      assert_valid_keys @response.first, %w(name
        container_format
        disk_format
        checksum
        id
        size
      )
    end
  end

  describe "#all true" do
    before do
      VCR.use_cassette "resource_all_verbose" do
        @response = CONNECTION.resource.all true
      end
    end

    it "returns a detailed hash of images" do
      @response.size.must_be :>=, 1
    end

    it "returns metadata" do
      assert_valid_keys @response.first, %w(
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
  end

  describe "#find" do
    it "returns X-Image-Meta-* headers as a hash" do
      VCR.use_cassette "resource_find" do
        response = CONNECTION.resource.find 6

        assert_valid_keys response, %w(
          property_distro
          id
          property_arch
          deleted
          container_format
          property_uploader
          location
          deleted_at
          created_at
          size
          status
          property_type
          property_kernel_name
          is_public
          property_kernel_id
          updated_at
          checksum
          property_version
          disk_format
          name
        )
      end
    end
  end
end
