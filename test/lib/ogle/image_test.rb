require "test_helper"

CONNECTION = Ogle::Client.new(
  :host => "glance.trunk"
)

describe Ogle::Image do
  describe "#all" do
    before do
      VCR.use_cassette "image_all" do
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
      VCR.use_cassette "image_all_with_details" do
        @response = CONNECTION.image.all true
      end
    end

    it "returns all images with details" do
      @response.size.must_be :>=, 1
    end

    it "returns metadata with details" do
      must_have_valid_methods @response.first, DETAILED_METADATA_KEYS
    end
  end

  describe "#runable" do
    before do
      VCR.use_cassette "image_runable" do
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
    VCR.use_cassette "image_runable_with_details" do
      response = CONNECTION.image.runable true

      it "returns metadata with details" do
        must_have_valid_methods response.first, DETAILED_METADATA_KEYS
      end
    end
  end

  describe "#find" do
    before do
      VCR.use_cassette "image_find" do
        @image_id = upload("image_find").id
        @response = CONNECTION.image.find @image_id
      end
    end

    after do
      VCR.use_cassette "image_find" do
        CONNECTION.image.destroy @image_id
      end
    end

    it "returns metadata with details" do
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

  ### TODO:
  # - Return an Object

  describe "#destroy" do
    before do
      VCR.use_cassette "image_destroy" do
        @image_id = upload("image_destroy").id
      end
    end

    it "returns OK" do
      VCR.use_cassette "image_destroy" do
        response = CONNECTION.image.destroy @image_id

        response.code.must_equal "200"
      end
    end
  end

  describe "#create" do
    before do
      VCR.use_cassette "image_create" do
        @response = upload "test_image"
      end
    end

    it "returns metadata" do
      must_have_valid_methods @response, METADATA_KEYS
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

  ### TODO:
  # - Upload image to update in setup.

  #describe "#update" do
  #  VCR.use_cassette "image_update" do
  #    metadata = {
  #      "x-image-meta-is-public"        => "true",
  #      "x-image-met-property-test"     => "yes-updated",
  #      "x-image-meta-property-distro"  => "test-distro-updated",
  #      "x-image-meta-property-version" => "test-version-1.1"
  #    }

  #    response = CONNECTION.image.update "56", metadata

  #    it "returns an HTTP/1.1 200 OK" do
  #      reponse.code.must_equal "200"
  #    end
  #  end
  #end

  def must_have_valid_keys response, keys
    raise "The response passed in is empty." if response.keys.empty?
    response.keys.delete_if { |k| keys.include? k }.must_be_empty
  end

  def must_have_valid_methods response, keys
    keys.each { |k| response.respond_to? k }
  end

  def upload name
    image    = File.join TEST_ROOT, "support", "test-image"
    metadata = {
      "x-image-meta-is-public"            => "true",
      "x-image-meta-property-distro"      => "test-distro",
      "x-image-meta-property-arch"        => "test-arch",
      "x-image-meta-property-uploader"    => "test-uploader",
      "x-image-meta-property-type"        => "test-type",
      "x-image-meta-property-kernel_name" => "test-kernel-name",
      "x-image-meta-property-kernel_id"   => "test-kernel-id",
      "x-image-meta-property-version"     => "test-version"
    }

    CONNECTION.image.create name, image, metadata
  end
end

##
# These test expect images with ids of:
#   - for decimal (0-9)
#   - for hex >9

describe Ogle::ImageData do
  before do
    @decimal_image_id     = 4
    @hexadecimal_image_id = 36
  end
  
  describe "#to_ami_id" do
    it "return a valid ami id" do
      VCR.use_cassette "image_find_with_decimal" do
        @response = CONNECTION.image.find @decimal_image_id

        @response.to_ami_id.must_equal "ami-00000004"
      end
    end

    it "return a valid hex ami id" do
      VCR.use_cassette "image_find_with_hexadecimal" do
        @response = CONNECTION.image.find @hexadecimal_image_id

        @response.to_ami_id.must_equal "ami-00000024"
      end
    end
  end
end
