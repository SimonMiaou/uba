require 'test_helper'
require 'simple_cqrs/events'
require 'uba/event_store/memory_store'

module Uba
  module EventStore
    class MemoryStoreTest < Minitest::Test
      def test_save
        store = MemoryStore.new
        event = InventoryItemCreated.coerce! id: SecureRandom.uuid,
                                             name: Faker::RickAndMorty.character

        store.save_event(event)
      end

      def test_load_events_for_aggregate
        store = MemoryStore.new
        aggregate_id = SecureRandom.uuid

        create_event = InventoryItemCreated.coerce! id: aggregate_id,
                                                    name: Faker::RickAndMorty.character
        rename_event = InventoryItemRenamed.coerce! id: aggregate_id,
                                                    new_name: Faker::RickAndMorty.character
        noise_event = InventoryItemCreated.coerce! id: SecureRandom.uuid,
                                                   name: Faker::RickAndMorty.character

        store.save_event create_event
        store.save_event noise_event
        store.save_event rename_event

        assert_equal([create_event, rename_event],
                     store.load_events_for_aggregate(aggregate_id),
                     'return only event with given aggregate_id')
      end
    end
  end
end
