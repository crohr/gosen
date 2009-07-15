require 'gosen/model'
require 'json'

module Gosen
  class Site
    include Model
    attr_accessor :name, :environments, :uri, :latitude, :location, :security_contact, :uid, :type, :user_support_contact, :description, :longitude, :email_contact, :web, :sys_admin_contact

    def initialize(hash)
      @hash = hash
      populate_from_hash!(@hash)
    end

    def clusters
      return @clusters unless @clusters.nil?
      @clusters = []
      h = JSON.parse(Gosen::Session.session[@uri + "?depth=2"].get(:accept => 'application/json'))['clusters']
      h.each do |name, data|
        @clusters.push(Gosen::Cluster.new(data))
      end
      return @clusters.sort! { |a,b| a.uid <=> b.uid }
    end
  end
end
