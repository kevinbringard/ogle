require "test_helper"

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
    response = CONNECTION.resource.find id
    puts response
    puts response.code
  end
end
