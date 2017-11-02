require 'active_support/core_ext/string'
require 'uba/configuration'
require 'uba/version'

module Uba
  def self.configure
    yield config if block_given?
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.message_name_to_class(message_name)
    # TODO: test
    message_name.to_s.camelize.constantize
  end
end
