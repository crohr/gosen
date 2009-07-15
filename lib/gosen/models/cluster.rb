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
      h = JSON.parse(Gosen::Session.session[@uri + "?depth=2"].get(:accept => 'application/json'))['nodes']
      h.each do |name, data|
        @nodes.push(Gosen::Node.new(data))
      end
      return @nodes.sort! { |a,b| a.uid <=> b.uid }
    end
  end
end
