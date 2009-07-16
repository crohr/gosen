require 'gosen/model'
require 'json'

module Gosen
  class User
    attr_reader :login

    def initialize(login)
      @login = login
    end

    def uri
      "users/#{@login}"
    end

    def jobsets
      @jobsets = []
      h = JSON.parse(Gosen::Session.jobset[self.uri]['jobsets'].get(:accept => 'application/json'))
      h.each do |jobset|
        @jobsets.push(Gosen::Jobset.new(jobset))
      end
      return @jobsets
    end
    
    def create_jobset(params)
      json = Gosen::Session.jobset[self.uri]['jobsets'].post(params.to_json, :accept => 'application/json', :content_type => 'application/json')
      return Gosen::Jobset.new(JSON.parse(json))
    end
  end
end
