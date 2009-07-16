require 'gosen/model'
require 'json'

module Gosen
  class Site
    include Model
    attr_accessor :name, :environments, :uri, :latitude, :location, :security_contact, :uid, :type, :user_support_contact, :description, :longitude, :email_contact, :web, :sys_admin_contact

    def initialize(hash)
      @hash = hash
      populate_from_hash!(@hash)
      @clusters = nil
    end

    def clusters
      return @clusters unless @clusters.nil?
      @clusters = []
      h = JSON.parse(Gosen::Session.reference[@uri + "?depth=2"].get(:accept => 'application/json'))['clusters']
      h.each do |name, data|
        @clusters.push(Gosen::Cluster.new(data))
      end
      return @clusters.sort! { |a,b| a.uid <=> b.uid }
    end

    class Status
      include Model
      attr_accessor :hardware, :system, :uri, :generated_at

      def initialize(hash)
        populate_from_hash!(hash)
        @hardware = Gosen::Site::Status::Hardware.new(hash['aggregated_nodes_stats']['hardware_state'])
        @system = Gosen::Site::Status::System.new(hash['aggregated_nodes_stats']['system_state'])
      end

      class System
        include Model
        attr_accessor :busy, :besteffort, :free, :unknown

        def initialize(hash)
          @busy = @besteffort = @free = @unknown = 0
          populate_from_hash!(hash)
        end
      end

      class Hardware
        include Model
        attr_accessor :alive, :dead, :absent, :suspected

        def initialize(hash)
          @alive = @dead = @absent = @suspected = 0
          populate_from_hash!(hash)
        end
      end
    end

    def status
      base_uri = @uri.sub(/\/versions\/[a-f0-9]+/, '')
      h = JSON.parse(Gosen::Session.monitoring["#{base_uri}/statuses/current"].get(:accept => 'application/json'))
      return Gosen::Site::Status.new(h)
    end
  end
end
