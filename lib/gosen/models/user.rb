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
  end
end
