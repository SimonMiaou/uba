module Uba
  module Bus
    class FakeBus
      def initialize
        @handlers = {}
      end

      def register_handler(message_name, &blck)
        @handlers[message_name.to_s] ||= []
        @handlers[message_name.to_s] << blck
      end

      def publish(event)
        return unless @handlers.key?(event.name)

        @handlers[event.name].each do |blck|
          blck.call(event)
        end
      end

      def trigger(command)
        return unless @handlers.key?(command.name)

        @handlers[command.name].each do |blck|
          blck.call(command)
        end
      end
    end
  end
end
