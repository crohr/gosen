require 'gosen/model'
require 'json'

module Gosen
  class Site
    include Model
    attr_accessor :name, :environments, :uri, :latitude, :location, :security_contact, :uid, :type, :user_support_contact, :description, :longitude, :email_contact, :web, :sys_admin_contact

    def clusters
      return @clusters unless @clusters.nil?
      @clusters = []
      @hash = JSON.parse(Gosen::Session.session[@uri].get(:accept => 'application/json'))
      @hash['clusters'].each do |cluster, uri|
        clusterhash = JSON.parse(Gosen::Session.session[uri].get(:accept => 'application/json'))
        @clusters.push(Gosen::Site.new(clusterhash))
      end
      return @clusters.sort! { |a,b| a.uid <=> b.uid }
    end
  end
end
