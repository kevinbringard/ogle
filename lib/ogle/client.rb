require "hugs"

module Ogle
  class Client
    ##
    #
    #
    #
    
    def initialize options
      @connection = Hugs::Client.new(
        :host     => options[:host],
        :scheme   => options[:scheme] || "http",
        :port     => options[:port] || 9292,
      )
      @connection.raise_4xx = true
      @connection.raise_5xx = true
    end
  end
end
