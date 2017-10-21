module Uba
  module EventStore
    class MemoryStore
      def initialize
        @events = []
      end

      def save_event(event)
        @events << event
      end

      def load_events_for_aggregate(aggregate_id)
        @events.select { |event| event.aggregate_id == aggregate_id }
      end
    end
  end
end
