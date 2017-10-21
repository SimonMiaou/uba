require 'test_helper'
require 'uba/event'

module Uba
  class EventTest < Minitest::Test
    def test_aggregate_id
      aggregate_id = SecureRandom.uuid
      event = MessageWithInferableAggregateId.coerce!(id: aggregate_id)

      assert_equal aggregate_id, event.aggregate_id, 'infer aggregate_id from event id key'

      assert_raises Uba::CouldntInferAggregateId, 'raise an exception when couldnt infer aggregate_id' do
        MessageWithoutInferableAggregateId.coerce!(foo: SecureRandom.uuid).aggregate_id
      end
    end

    class MessageWithInferableAggregateId < Event
      define do
        { id: _String }
      end
    end

    class MessageWithoutInferableAggregateId < Event
      define do
        { foo: _String }
      end
    end
  end
end
