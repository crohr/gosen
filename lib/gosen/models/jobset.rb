require 'gosen/model'
require 'json'

module Gosen
  class Jobset
    include Model
    attr_accessor :user, :name, :uri, :updated_at, :misc, :project, :public_uri, :jobs_uri, :id, :created_at

    def initialize(hash)
      populate_from_hash!(hash)
    end

    def jobs
      @jobs = []
      h = JSON.parse(Gosen::Session.jobset[@jobs_uri].get(:accept => 'application/json'))
      h.each do |job|
        @jobs.push(Gosen::Job.new(job))
      end
      return @jobs
    end
  end
end
