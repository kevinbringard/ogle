require "test_helper"

CONNECTION = Ogle::Client.new(
  :host => "10.3.170.32"
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
      must_have_valid_keys @response.first, METADATA_KEYS
    end
  end

  describe "#all with details" do
    before do
      VCR.use_cassette "images_all_with_details" do
        @response = CONNECTION.image.all true
      end
    end

    it "returns a detailed hash of images" do
      @response.size.must_be :>=, 1
    end

    it "returns metadata" do
      must_have_valid_keys @response.first, DETAILED_METADATA_KEYS
    end
  end

  describe "#runable" do
    before do
      VCR.use_cassette "images_runable" do
        @response = CONNECTION.image.runable
      end
    end

    it "returns a hash of all images which are runable" do
      @response.any? { |i| i['id'] != 1}.must_equal true
    end

    it "returns metadata" do
      must_have_valid_keys @response.first, METADATA_KEYS
    end
  end

  describe "#runable with details" do
    VCR.use_cassette "images_runable_with_details" do
      response = CONNECTION.image.runable(true)

      it "returns metadata" do
        must_have_valid_keys response.first, DETAILED_METADATA_KEYS
      end
    end
  end

  describe "#find" do
    before do
      VCR.use_cassette "images_find" do
        @response = CONNECTION.image.find 6
      end
    end

    it "returns X-Image-Meta-* headers as a hash" do
      must_have_valid_keys @response, DETAILED_METADATA_KEYS
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

  describe "#delete" do
    VCR.use_cassette "image_delete" do
      response = CONNECTION.image.delete 15
    
      it "returns an HTTP/1.1 200 OK" do
        response.code.must_equal "200"
      end
    end
  end
end
