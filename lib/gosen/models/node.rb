require 'gosen/model'
require 'json'

module Gosen
  class Node
    include Model
    attr_accessor :architecture, :main_memory, :network_adapters, :operating_system, :processor, :storage_devices, :supported_job_types, :type, :uid, :uri

    def initialize(hash)
      @hash = hash
      populate_from_hash!(@hash)
      @architecture = Gosen::Node::Architecture.new(@hash['architecture'])
      @main_memory = Gosen::Node::MainMemory.new(@hash['main_memory'])
      @network_adapters = []
      @hash['network_adapters'].each do |net|
        @network_adapters.push(Gosen::Node::NetworkAdapter.new(net))
      end
      @operating_system = Gosen::Node::OperatingSystem.new(@hash['operating_system'])
      @processor = Gosen::Node::Processor.new(@hash['processor'])
      @storage_devices = []
      @hash['storage_devices'].each do |net|
        @storage_devices.push(Gosen::Node::StorageDevice.new(net))
      end
      @supported_job_types = Gosen::Node::SupportedJobType.new(@hash['supported_job_types'])
    end

    class Architecture
      include Model
      attr_accessor :smp_size, :platform_type, :smt_size
    end

    class MainMemory
      include Model
      attr_accessor :ram_size, :virtual_size
    end

    class NetworkAdapter
      include Model
      attr_accessor :rate, :enabled, :interface, :driver
    end

    class OperatingSystem
      include Model
      attr_accessor :kernel, :name, :version, :release
    end

    class Processor
      include Model
      attr_accessor :model, :cache_l1d, :clock_speed, :cache_l1, :other_description, :version, :cache_l2, :instruction_set, :vendor, :cache_l1i
    end

    class StorageDevice
      include Model
      attr_accessor :size, :interface, :driver
    end

    class SupportedJobType
      include Model
      attr_accessor :virtual, :besteffort, :deploy
    end

  end
end
