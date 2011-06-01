require "test_helper"

CONNECTION = Ogle::Client.new(
  :host => "glance.trunk"
)

describe Ogle::Image do
  describe "#all" do
    before do
      VCR.use_cassette "images_all" do
        @response = CONNECTION.image.all
      end
    end

    it "returns all images" do
      @response.size.must_be :>=, 1
    end

    it "returns metadata" do
      must_have_valid_methods @response.first, METADATA_KEYS
    end
  end

  describe "#all with details" do
    before do
      VCR.use_cassette "images_all_with_details" do
        @response = CONNECTION.image.all true
      end
    end

    it "returns detailed images" do
      @response.size.must_be :>=, 1
    end

    it "returns metadata" do
      must_have_valid_methods @response.first, DETAILED_METADATA_KEYS
    end
  end

  describe "#runable" do
    before do
      VCR.use_cassette "images_runable" do
        @response = CONNECTION.image.runable
      end
    end

    it "returns all images which are runable" do
      @response.any? { |i| i.id != 1}.must_equal true
    end

    it "returns metadata" do
      must_have_valid_methods @response.first, METADATA_KEYS
    end
  end

  describe "#runable with details" do
    VCR.use_cassette "images_runable_with_details" do
      response = CONNECTION.image.runable(true)

      it "returns metadata" do
        must_have_valid_methods response.first, DETAILED_METADATA_KEYS
      end
    end
  end

  describe "#find" do
    before do
      VCR.use_cassette "images_find" do
        @response = CONNECTION.image.find 4
      end
    end

    it "returns X-Image-Meta-* headers as a hash" do
      must_have_valid_methods @response, DETAILED_METADATA_KEYS
    end

    it "returns a nested properties hash" do
      must_have_valid_keys @response.properties, %w(
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

  describe "#destroy" do
    VCR.use_cassette "image_destroy" do
      response = CONNECTION.image.destroy 41

      it "returns an HTTP/1.1 300 OK" do
        response.code.must_equal "300"
      end
    end
  end

  describe "#create" do
    VCR.use_cassette "image_create" do
      testfile = File.join TEST_ROOT, "support", "test-image"
      metadata = { 
        "x-image-meta-property-test" => "yes",
        "x-image-meta-property-distro" => "test-distro",
        "x-image-meta-property-version" => "test-version-1"
      }

      response = CONNECTION.image.create "#{testfile}", "test-image", metadata

      it "returns an HTTP/1.1 200 OK" do
        response.code.must_equal "200"
      end
    end
  end


  def must_have_valid_keys response, keys
    raise "The response passed in is empty." if response.keys.empty?
    response.keys.delete_if { |k| keys.include? k }.must_be_empty
  end

  def must_have_valid_methods response, keys
    keys.each { |k| response.respond_to? k }
  end
end

describe Ogle::ImageData do
  describe "#to_ami_id" do
    it "return a valid ami id" do
      VCR.use_cassette "image_find" do
        @response = CONNECTION.image.find 4

        @response.to_ami_id.must_equal "ami-00000004"
      end
    end

    it "return a valid hex ami id" do
      VCR.use_cassette "image_find" do
        @response = CONNECTION.image.find 36

        @response.to_ami_id.must_equal "ami-00000024"
      end
    end
  end
end
