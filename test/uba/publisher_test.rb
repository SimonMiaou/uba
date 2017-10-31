require 'test_helper'
require 'uba/bus/fake_bus'
require 'uba/publisher'

module Uba
  class PublisherTest < Minitest::Test
    class DummyPublisher
      include Publisher
    end

    def test_publish
      bus = Bus::FakeBus.new
      publisher = DummyPublisher.new bus
      item_id = SecureRandom.uuid

      publisher.publish :inventory_item_created, id: item_id, name: Faker::RickAndMorty.character

      # TODO: test bus
    end

    def test_trigger
      bus = Bus::FakeBus.new
      publisher = DummyPublisher.new bus
      item_id = SecureRandom.uuid

      publisher.trigger :create_inventory_item, inventory_item_id: item_id, name: Faker::RickAndMorty.character

      # TODO: test bus
    end
  end
end
