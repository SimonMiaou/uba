require 'test_helper'
require 'uba/bus/fake_bus'
require 'uba/event_store/memory_store'

class UbaTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Uba::VERSION
  end

  def test_configure_and_config
    Uba.configure do |c|
      c.bus Uba::Bus::FakeBus.new
      c.event_store Uba::EventStore::MemoryStore.new
    end

    assert_equal Uba::Bus::FakeBus, Uba.config.bus.class
    assert_equal Uba::EventStore::MemoryStore, Uba.config.event_store.class
  end
end
