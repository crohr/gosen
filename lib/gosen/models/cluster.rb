require 'gosen/model'
require 'json'

module Gosen
  class Cluster
    include Model
    attr_accessor :model, :created_at, :uri, :uid, :type

    def initialize(hash)
      @hash = hash
      populate_from_hash!(@hash)
    end

    def nodes
      return @nodes unless @nodes.nil?
      @nodes = []
      @hash['nodes'].each do |node, uri|
        nodehash = JSON.parse(Gosen::Session.session[uri].get(:accept => 'application/json'))
        @nodes.push(Gosen::Node.new(nodehash))
      end
      return @nodes.sort! { |a,b| a.uid <=> b.uid }
    end
  end
end
