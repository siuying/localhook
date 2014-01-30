require 'claide'
require 'colored'

require_relative './event_source'
require_relative './webhook_forwarder'

module Localhook
  class Command < ::CLAide::Command
    attr_reader :remote_server, :local_server
    self.command = 'localhook'
    self.description = "Localhook let you receive webhooks on localhost."
    self.arguments   = "<remote-server> <local-server>"

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
      if @remote_server.nil?
        help! "missing remote-server parameter"
      end
      if @local_server.nil?
        help! "missing local-server parameter"
      end
    end

    def run
      EventMachine.run do
        puts "forward remote server (#{@remote_server}) webhooks to #{@local_server}"
        @forwarder  = WebhookForwarder.new(@local_server)
        @source     = EventSource.new(@remote_server, @forwarder)
        @source.error do |error|
          puts "error connecting to eventsource: #{error}"
        end
        @source.start
      end
    end
  end
end 