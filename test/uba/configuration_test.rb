require 'test_helper'
require 'uba/bus/fake_bus'
require 'uba/configuration'
require 'uba/event_store/memory_store'

module Uba
  class ConfigurationTest < Minitest::Test
    def test_bus
      configuration = Configuration.new

      exception = assert_raises Uba::ConfigurationMustBeDefined, 'raise an exception when bus is not set' do
        configuration.bus
      end
      assert_equal 'bus must be defined', exception.message

      configuration.bus Bus::FakeBus.new

      assert_equal Bus::FakeBus, configuration.bus.class, 'allow to change the value'
    end

    def test_event_store
      configuration = Configuration.new

      exception = assert_raises Uba::ConfigurationMustBeDefined, 'raise an exception when event_store is not set' do
        configuration.event_store
      end
      assert_equal 'event_store must be defined', exception.message

      configuration.event_store EventStore::MemoryStore.new

      assert_equal EventStore::MemoryStore, configuration.event_store.class, 'allow to change the value'
    end
  end
end
