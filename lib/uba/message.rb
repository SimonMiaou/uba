require 'rschema'
require 'uba/exceptions'

module Uba
  class Message
    attr_reader :payload

    def self.define(&blck)
      @schema = RSchema.define_hash(&blck)
    end

    def self.coerce!(payload)
      raise InvalidSchema unless valid?(payload)
      new(payload)
    end

    def self.valid?(payload)
      @schema.valid?(payload)
    end

    def initialize(payload)
      @payload = payload
    end

    def [](key)
      payload[key]
    end
  end
end
