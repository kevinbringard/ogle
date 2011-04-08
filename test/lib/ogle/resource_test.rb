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
    response = CONNECTION.resource.find 6
  #  puts CONNECTION.inspect
  #  puts response.inspect
  #  puts response.body
  #  #puts response.code
  end
end
