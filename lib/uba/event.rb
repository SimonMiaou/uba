require 'uba/exceptions'
require 'uba/message'

module Uba
  class Event < Message
    def aggregate_id
      return payload[:id] if payload.key? :id

      raise CouldntInferAggregateId
    end
  end
end
