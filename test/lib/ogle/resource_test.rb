require "test_helper"

describe Ogle::Resource do
  describe "#all" do
    response = CONNECTION.resource.all
    puts response
    puts response.body
    puts response.code
  end
end
