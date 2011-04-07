module Ogle
  class Resource
    def initialize connection
      @connection = connection
    end

    ##
    # Returns information about images.
    #
    # +verbose+: A Boolean toggling the returning of
    # additional image information.

    def all verbose = false
      path = verbose ? "/images" : "/images/detail"

      response = @connection.get path
      
      response.body['images']
    end

    ##
    # Returns information about the given 'image_id'.
    #
    # +image_id+: A String representing an image_id.

    def find image_id
      @connection.head "/images/#{image_id}"

      ### TODO: Return a new Hash with all the X-Image-Meta-*
    end
  end
end
