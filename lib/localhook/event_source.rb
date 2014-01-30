require 'em-eventsource'
require 'yajl'

module Localhook
  class EventSource < ::EventMachine::EventSource
    attr_reader :parser
    attr_reader :forwarder

    def initialize(url, forwarder)
      super(url)

      @forwarder = forwarder
      @parser = Yajl::Parser.new(:symbolize_keys => true)
      self.message do |message|
        parse_line(message)
      end
    end

    def parse_line(message)
      data = parser.parse(message)
      case data[:action]
      when "post"
        # convert headers array to Hash, if needed
        headers = data[:headers]
        headers = headers.inject({}){|map, v| map[v[0]] = v[1]; map } if headers.is_a?(Array)
        path = data[:path]
        query = data[:query_string]
        body = data[:body]
        forwarder.post(path, query, headers, body)
      end
    end
  end
end 