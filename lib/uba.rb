require 'uba/configuration'
require 'uba/version'

module Uba
  def self.configure
    yield config if block_given?
  end

  def self.config
    @config ||= Configuration.new
  end
end
