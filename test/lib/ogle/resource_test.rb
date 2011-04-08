require "test_helper"

CONNECTION = Ogle::Client.new(
  :host => "10.1.170.33"
)

describe Ogle::Resource do
  describe "#all" do
    it "returns a hash of images" do
      VCR.use_cassette "resource_all" do
        response = CONNECTION.resource.all

        response.size.must_equal 6
      end
    end
  end

  describe "#all true" do
    it "returns a detailed hash of images (verbose = true)" do
      VCR.use_cassette "resource_all_verbose" do
        response = CONNECTION.resource.all true

        response.size.must_equal 6
      end
    end
  end

  describe "#find" do
    it "returns X-Image-Meta-* headers as a hash" do
      VCR.use_cassette "resource_find" do
        response = CONNECTION.resource.find 6

        response.size.must_equal 20
      end
    end
  end
end
