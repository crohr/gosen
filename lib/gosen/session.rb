require 'rest_client'

module Gosen
  class Session
    def initialize(url)
      @@session = RestClient::Resource.new(url)
    end

    def Session.session
      @@session
    end
  end
end
