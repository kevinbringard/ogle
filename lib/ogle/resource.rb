module Ogle
  class Resource
    def initialize connection
      @connection = connection
    end

    ##
    # Get a listing of all the images Glance knows about

    def all
      @connection.get "/images"
    end

    ##
    # Get a detailed listing on all public VM images

    def details
      @connection.get "/images/detail"
    end

    ##
    # Get detailed meta-data on a specific image

    def find image_id
      @connection.head "/images/#{image_id}"
    end
  end
end
