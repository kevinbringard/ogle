require "test_helper"

CONNECTION = Ogle::Client.new(
  :host => "10.1.170.33"
)


describe Ogle::Resource do
  describe "#all" do
    response = CONNECTION.resource.all
    puts response
    puts response.body
    puts response.code
  end

  describe "#details" do
    response = CONNECTION.resource.details
    puts response
    puts response.body
    puts response.code
  end

  describe "#find" do
    response = CONNECTION.resource.find 6
    puts response
    puts response.code
  end
end
