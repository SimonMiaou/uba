module Uba
  module Publisher
    def initialize(bus)
      @bus = bus
    end

    def publish(event_name, payload)
      # TODO
    end

    def trigger(command_name, payload)
      # TODO
    end
  end
end
