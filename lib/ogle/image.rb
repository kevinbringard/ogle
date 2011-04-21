module Ogle
  class ImageData
    def initialize hash
      class << self; self end.instance_eval do
        hash.each_pair.each do |k, v|
          define_method k do
            v
          end
        end
      end
    end
  end

  class Image
    def initialize connection
      @connection = connection
    end

    ##
    # Returns information about images.
    #
    # +details+: A Boolean toggling the returning of detailed image
    # information.

    def all details = false
      path = details ? "/images/detail" : "/images"

      response = @connection.get path

      response.body['images'].collect do |r|
        ImageData.new r
      end
    end

    ##
    # Returns information about the given 'image_id'.
    #
    # +image_id+: A String representing an image_id.

    def find image_id
      response = @connection.head "/images/#{image_id}"

      ImageData.new(
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
      )
    end

    ##
    # Return only runable images.
    #
    # +details+: A Boolean toggling the returning of detailed image
    # information.

    def runable details = false
      all(details).select do |image|
        runable? image
      end
    end

    ##
    # Delete an image.
    #
    # +image_id+: A String representing an image_id.

    def delete image_id
      response = @connection.delete "/images/#{image_id}"
    end

  private
    ##
    # Kernels and Ramdisks are not runable, so we want to ignore them.

    def runable? image
      image.container_format == "ami" &&
      image.disk_format == "ami"
    end
  end
end
