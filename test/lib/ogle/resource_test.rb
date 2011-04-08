require "test_helper"

CONNECTION = Ogle::Client.new(
  :host => "10.1.170.33"
)

describe Ogle::Resource do
  describe "#all" do
    it "returns a hash of images" do
      response = CONNECTION.resource.all

      response.size.must_equal 6
    end
  end

  describe "#find" do
    it "returns X-Image-Meta-* headers as a hash" do
      response = CONNECTION.resource.find 6

      response.size.must_equal 20
    end
  end
end
