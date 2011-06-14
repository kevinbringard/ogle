%w(hugs ogle/image).each { |r| require r }

module Ogle
  class Client
    ##
    # Required:
    # +host+: A string containing the hostname or IP of your glance server

    def initialize options
      @connection = Hugs::Client.new(
        :host         => options[:host],
        :scheme       => options[:scheme] || "http",
        :port         => options[:port] || 9292,
        :user         => options[:user] || 'nil',
        :password     => options[:pass] || 'nil',
        :raise_errors => true
      )
    end

    def image
      @image ||= Image.new @connection
    end
  end
end
