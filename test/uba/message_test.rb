require 'test_helper'
require 'uba/message'

module Uba
  class MessageTest < Minitest::Test
    def test_name
      message = Message.new(foo: :bar)

      assert_equal String, message.name.class, 'should return a string'
    end

    def test_payload
      payload = { foo: :bar }
      message = Message.new(payload)

      assert_equal payload, message.payload, 'return the payload'
    end

    def test_hsh
      message = Message.new(foo: :bar)

      assert_equal :bar, message[:foo], 'return the value from the payload'
    end

    def test_valid?
      assert MessageWithSchema.valid?(foo: :bar), 'payload id valid'
      refute MessageWithSchema.valid?(bar: :foo), 'payload id invalid'
    end

    def test_coerce!
      payload = { foo: :bar }
      assert_equal payload, MessageWithSchema.coerce!(payload).payload, 'init message'

      assert_raises Uba::InvalidSchema, 'raise an exception when payload is invalid' do
        MessageWithSchema.coerce!(bar: :foo)
      end
    end

    class MessageWithSchema < Message
      define do
        { foo: _Symbol }
      end
    end
  end
end
