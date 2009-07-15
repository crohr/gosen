require 'gosen/model'
require 'gosen/session'
require 'gosen/models/site'
require 'json'

module Gosen
  class Grid
    include Model
    attr_accessor :environments, :uri, :uid, :type

    def initialize
      @hash = JSON.parse(Gosen::Session.session['/versions/current'].get(:accept => 'application/json'))
      populate_from_hash!(@hash)
    end

    def sites
      return @sites unless @sites.nil?
      @sites = []
      h = JSON.parse(Gosen::Session.session[@uri + "?depth=2"].get(:accept => 'application/json'))['sites']
      h.each do |name, data|
        @sites.push(Gosen::Site.new(data))
      end
      return @sites.sort! { |a,b| a.name <=> b.name }
    end
  end
end
