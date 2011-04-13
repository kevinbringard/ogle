require "test_helper"

CONNECTION = Ogle::Client.new(
  :host => "10.1.170.32"
)

def must_have_valid_keys response, keys
  raise "The response passed in is empty." if response.keys.empty?
  response.keys.delete_if { |k| keys.include? k }.must_be_empty
end

describe Ogle::Image do
  describe "#all" do
    before do
      VCR.use_cassette "images_all" do
        @response = CONNECTION.image.all
      end
    end

    it "returns a hash of images" do
      @response.size.must_be :>=, 1
    end

    it "returns metadata" do
      must_have_valid_keys @response.first, %w(
        name
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
      VCR.use_cassette "images_all_verbose" do
        @response = CONNECTION.image.all true
      end
    end

    it "returns a detailed hash of images" do
      @response.size.must_be :>=, 1
    end

    it "returns metadata" do
      must_have_valid_keys @response.first, %w(
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

  describe "#all runable" do
    before do
      VCR.use_cassete "images_all_runable" do
        @response = CONNECTION.image.runable
      end
    end

    it "returns a hash of all images which are runable" do
      @response.size.must_be :>=, 1
    end
  end

  describe "#find" do
    before do
      VCR.use_cassette "images_find" do
        @response = CONNECTION.image.find 6
      end
    end

    ### TODO: May want to refactor these keys into a variable,
    ### TODO: since Images#find verbose shares them.
    it "returns X-Image-Meta-* headers as a hash" do
      must_have_valid_keys @response, %w(
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

    it "returns a nested properties hash" do
      must_have_valid_keys @response['properties'], %w(
        distro
        arch
        uploader
        type
        kernel_name
        kernel_id
        version
      )
    end
  end
end
