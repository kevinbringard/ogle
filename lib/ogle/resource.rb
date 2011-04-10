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
      response = @connection.head "/images/#{image_id}"

      Hash.new.tap do |h|
        properties = h['properties'] = Hash.new
        response.each_header do |k, v|
          case k.downcase.tr '-', '_'
            when %r{^x_image_meta_property_([a-z_]+)$}
              properties[$1] = v
            when %r{^x_image_meta_([a-z_]+)$}
              h[$1] = v
          end
        end
      end
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
