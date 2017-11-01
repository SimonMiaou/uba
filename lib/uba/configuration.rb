require 'uba/exceptions'

module Uba
  class Configuration
    def bus(value = nil)
      @bus = value unless value.nil?
      raise(ConfigurationMustBeDefined, 'bus must be defined') unless defined?(@bus)
      @bus
    end

    def event_store(value = nil)
      @event_store = value unless value.nil?
      raise(ConfigurationMustBeDefined, 'event_store must be defined') unless defined?(@event_store)
      @event_store
    end
  end
end
