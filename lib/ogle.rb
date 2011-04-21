require "ogle/client"

module Ogle
  class Rails
    def self.insert
      ::Ogle::ImageData.class_eval do
        include ActiveModel::Serialization
      end
    end
  end
end
