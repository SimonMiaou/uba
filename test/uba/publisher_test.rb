require 'test_helper'
require 'uba/bus/fake_bus'
require 'uba/event_store/memory_store'
require 'uba/publisher'

module Uba
  class PublisherTest < Minitest::Test
    class DummyPublisher
      include Publisher
    end

    def setup
      super

      Uba.configure do |c|
        c.bus Bus::FakeBus.new
        c.event_store EventStore::MemoryStore.new
      end
    end

    def test_publish
      publisher = DummyPublisher.new
      item_id = SecureRandom.uuid
      item_name = Faker::RickAndMorty.character
      event = nil

      Uba.config.bus.register_handler :inventory_item_created do |e|
        event = e
      end

      publisher.publish :inventory_item_created, id: item_id, name: item_name

      events = Uba.config.event_store.load_events_for_aggregate(item_id)

      assert_equal item_id, event[:id]
      assert_equal item_name, event[:name]

      assert_equal item_id, events.first[:id]
      assert_equal item_name, events.first[:name]
    end

    def test_trigger
      publisher = DummyPublisher.new
      item_id = SecureRandom.uuid
      item_name = Faker::RickAndMorty.character
      command = nil

      Uba.config.bus.register_handler :create_inventory_item do |c|
        command = c
      end

      publisher.trigger :create_inventory_item, inventory_item_id: item_id, name: item_name

      assert_equal item_id, command[:inventory_item_id]
      assert_equal item_name, command[:name]

      # TODO: saved commands?
    end
  end
end
