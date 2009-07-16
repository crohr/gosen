require 'rest_client'

module Gosen
  class Session

    REFERENCE_VERSION = "1.0-stable"
    MONITORING_VERSION = "1.0-stable"
    JOBSET_VERSION = "sid"

    def initialize(url)
      @@session = RestClient::Resource.new(url)
    end

    def Session.reference
      @@session[REFERENCE_VERSION]
    end

    def Session.monitoring
      @@session[MONITORING_VERSION]
    end

    def Session.jobset
      @@session[JOBSET_VERSION]
    end
  end
end
