require 'net/http'
require 'uri'
require 'rearden_notifier/rearden' if defined? Rails
require "rearden_notifier/version"
require 'rearden_notifier/configuration'
require 'rearden_notifier/error'
require 'rearden_notifier/sender'

module ReardenNotifier
  class << self

    attr_accessor :configuration  
    
    attr_accessor :sender

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

  end
end
