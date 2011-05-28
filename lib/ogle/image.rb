module Ogle
  class ImageData
    ##
    # Return a valid ami id from the given 'glance id'.
    #
    # +glance_id+: A String representing an image id in glance.
    #
    # Note:
    #   Glance image ids differ from those used by the EC2 API.
    #   Currently there is no way to query EC2 for a glance_id
    #   or vice versa.

    def to_ami_id
      hex    = self.id.to_i.to_s 16
      padded = hex.to_s.rjust 8,"0"

      "ami-#{padded}"
    end

    attr_accessor :attributes
    def initialize attributes
      @attributes = attributes
      class << self; self end.instance_eval do
        attributes.each_pair.each do |k, v|
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
      path = details ? "/v1/images/detail" : "/v1/images"

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
      response = @connection.head "/v1/images/#{image_id}"

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

    def destroy image_id
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
