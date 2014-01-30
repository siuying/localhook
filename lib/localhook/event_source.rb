require 'em-eventsource'
require 'yajl'

module Localhook
  class EventSource < ::EventMachine::EventSource
    attr_reader :forwarder

    VALID_URL = %r{^(https?://[^/]+)/?$}

    def initialize(base_url, forwarder)
      unless base_url =~ VALID_URL
        raise ArgumentError, "Invalid base_url \"#{base_url}\", it should be in format: (https|http)://<host>(:<port>)?/?"
      end

      base_url = base_url.match(VALID_URL)[1]
      super("#{base_url}/_localhook")

      @forwarder = forwarder

      @parser = Yajl::Parser.new(:symbolize_keys => true)
      @parser.on_parse_complete = method(:data_parsed)
      self.message do |message|
        @parser.parse(message)
      end

      # never timeout
      self.inactivity_timeout = 0
    end

    def data_parsed(data)
      # binding.pry
      case data[:action]
      when "post"
        # convert headers array to Hash, if needed
        headers = data[:headers]
        headers = headers.inject({}){|map, v| map[v[0]] = v[1]; map } if headers.is_a?(Array)
        path = data[:path]
        query = data[:query_string]
        body = data[:body]
        forwarder.post(path, query, headers, body)
      else
        raise "unknown action '#{data[:action]}' (#{data}"
      end
    end
  end
end 