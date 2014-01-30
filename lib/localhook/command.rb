require 'claide'
require 'colored'

require_relative './event_source'
require_relative './webhook_forwarder'

module Localhook
  class Command < ::CLAide::Command
    attr_reader :remote_server, :local_server
    self.description = "Listen a webhook locally via Localhook service."

    def initialize(argv)
      @remote_server = argv.shift_argument
      @local_server  = argv.shift_argument
      super
    end

    def self.options
      [
        ['--help', 'display help']
      ].concat(super)
    end

    def validate!
      if @remote_server.nil? || @local_server.nil?
        help! "usage: localhook <remote-server> <local-server>"
      end
    end

    def run
      EventMachine.run do
        @forwarder  = WebhookForwarder.new(@remote_server)
        @source     = Localhook::EventSource.new(@local_server, forwarder)
        @source.start
      end
    end
  end
end 