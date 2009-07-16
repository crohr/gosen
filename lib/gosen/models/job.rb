require 'gosen/model'
require 'json'

module Gosen
  class Job
    include Model
    attr_accessor :resources_uri, :created_at, :uri, :command, :ssh_public_key_uri, :ssh_private_key_uri, :cluster_jobs, :id, :ssh_key_path, :state, :cluster_jobs

    def initialize(hash)
      @hash = hash
      populate_from_hash!(@hash)
      @cluster_jobs = []
      @hash['cluster_jobs'].each do |cj|
        @cluster_jobs.push(Gosen::Job::Cluster.new(cj))
      end
    end

    class Cluster
      include Model
      attr_accessor :dependencies, :name, :assigned_resources, :scheduledStart, :uri, :command, :walltime, :reservation, :project, :submissionTime, :wanted_resources, :jobType, :events, :id, :cluster, :types, :resubmit_job_id, :startTime, :launchingDirectory, :queue, :assigned_network_address, :cpuset_name, :message, :state, :owner, :properties

      def initialize(hash)
        fullhash = JSON.parse(Gosen::Session.jobset[hash['uri']].get(:accept => 'application/json'))
        populate_from_hash!(fullhash)
        @events = []
        fullhash['events'].each do |e|
          @events.push(Gosen::Job::Cluster::Event.new(e))
        end
      end

      class Event
        include Model
        attr_accessor :event_id, :date, :type, :to_check, :description, :job_id
      end
    end
  end
end
