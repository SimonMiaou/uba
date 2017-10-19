require 'test_helper'
require 'simple_cqrs/commands'
require 'simple_cqrs/events'
require 'uba/bus/fake_bus'

module Uba
  module Bus
    class FakeBusTest < Minitest::Test
      def test_register_handler_allow_symbol_or_string
        bus = FakeBus.new
        item_created_id = SecureRandom.uuid
        items_created_count = 0

        bus.register_handler :inventory_item_created do |_event|
          items_created_count += 1
        end

        bus.register_handler 'inventory_item_created' do |_event|
          items_created_count += 1
        end

        bus.publish InventoryItemCreated.coerce!(id: item_created_id,
                                                 name: Faker::RickAndMorty.character)

        assert_equal 2, items_created_count
      end

      def test_publish_to_the_right_handler
        bus = FakeBus.new
        item_created_id = SecureRandom.uuid
        item_deactivated_id = SecureRandom.uuid
        foo_value = bar_value = nil

        bus.register_handler :inventory_item_created do |event|
          foo_value = event[:id]
        end

        bus.register_handler :inventory_item_deactivated do |event|
          bar_value = event[:id]
        end

        bus.publish InventoryItemCreated.coerce!(id: item_created_id,
                                                 name: Faker::RickAndMorty.character)
        bus.publish InventoryItemDeactivated.coerce!(id: item_deactivated_id)

        assert_equal item_created_id, foo_value
        assert_equal item_deactivated_id, bar_value
      end

      def test_publish_to_mulitple_handlers
        bus = FakeBus.new
        item_created_id = SecureRandom.uuid
        first_handler = second_handler = nil

        bus.register_handler :inventory_item_created do |event|
          first_handler = event[:id]
        end

        bus.register_handler :inventory_item_created do |event|
          second_handler = event[:id]
        end

        bus.publish InventoryItemCreated.coerce!(id: item_created_id,
                                                 name: Faker::RickAndMorty.character)

        assert_equal item_created_id, first_handler
        assert_equal item_created_id, second_handler
      end

      def test_trigger_to_the_right_handler
        bus = FakeBus.new
        item_created_id = SecureRandom.uuid
        item_deactivated_id = SecureRandom.uuid
        foo_value = bar_value = nil

        bus.register_handler :create_inventory_item do |command|
          foo_value = command[:inventory_item_id]
        end

        bus.register_handler :deactivate_inventory_item do |command|
          bar_value = command[:inventory_item_id]
        end

        bus.trigger CreateInventoryItem.coerce!(inventory_item_id: item_created_id,
                                                name: Faker::RickAndMorty.character)
        bus.trigger DeactivateInventoryItem.coerce!(inventory_item_id: item_deactivated_id,
                                                    original_version: rand(10))

        assert_equal item_created_id, foo_value
        assert_equal item_deactivated_id, bar_value
      end

      def test_trigger_to_mulitple_handlers
        bus = FakeBus.new
        item_created_id = SecureRandom.uuid
        first_handler = second_handler = nil

        bus.register_handler :create_inventory_item do |command|
          first_handler = command[:inventory_item_id]
        end

        bus.register_handler :create_inventory_item do |command|
          second_handler = command[:inventory_item_id]
        end

        bus.trigger CreateInventoryItem.coerce!(inventory_item_id: item_created_id,
                                                name: Faker::RickAndMorty.character)

        assert_equal item_created_id, first_handler
        assert_equal item_created_id, second_handler
      end
    end
  end
end
