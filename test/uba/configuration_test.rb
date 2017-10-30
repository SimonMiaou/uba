require 'test_helper'
require 'uba/bus/fake_bus'
require 'uba/configuration'
require 'uba/event_store/memory_store'

module Uba
  class ConfigurationTest < Minitest::Test
    class DummyConfig
      include Configuration
    end

    def test_config_blck
      config = DummyConfig.new

      self_config = config.config do |c|
        c.bus Bus::FakeBus.new
        c.event_store Bus::FakeBus.new
      end

      assert_equal self_config, config, 'return self'
      assert_equal Bus::FakeBus, config.bus.class
      assert_equal Bus::FakeBus, config.event_store.class
    end

    def test_bus
      config = DummyConfig.new

      exception = assert_raises Uba::ConfigurationMustBeDefined, 'raise an exception when bus is not set' do
        config.bus
      end
      assert_equal 'bus must be defined', exception.message

      config.bus Bus::FakeBus.new

      assert_equal Bus::FakeBus, config.bus.class, 'allow to change the value'
    end

    def test_event_store
      config = DummyConfig.new

      exception = assert_raises Uba::ConfigurationMustBeDefined, 'raise an exception when event_store is not set' do
        config.event_store
      end
      assert_equal 'event_store must be defined', exception.message

      config.event_store EventStore::MemoryStore.new

      assert_equal EventStore::MemoryStore, config.event_store.class, 'allow to change the value'
    end
  end
end
