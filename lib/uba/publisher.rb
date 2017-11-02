module Uba
  module Publisher
    def publish(event_name, payload)
      event = Uba.message_name_to_class(event_name).coerce! payload

      Uba.config.event_store.save_event(event)
      Uba.config.bus.publish(event)
    end

    def trigger(command_name, payload)
      command = Uba.message_name_to_class(command_name).coerce! payload

      Uba.config.bus.trigger(command)
    end
  end
end
