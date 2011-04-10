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
      path = verbose ? "/images/detail" : "/images"

      response = @connection.get path

      response.body['images']
    end

    ##
    # Returns information about the given 'image_id'.
    #
    # +image_id+: A String representing an image_id.

    def find image_id
      headers = @connection.head "/images/#{image_id}"
      meta    = {}

      headers.each_header do |k, v|
        if k.downcase.match %r{^x-image-meta-([a-z-]+)$}
          key = $1.tr '-', '_'
          meta["#{key}"] = v
        end
      end

      meta
    end

    ##
    # Stores the disk provided disk image in glance
    # Stores provided meta-data about the image in glance
    #
    # +image_location+: A string representing the location of the image to updload

    def add image_location
    end

  end
end
