require 'em-http-request'

module Localhook
  # Forward webhook to destination.
  # Note: this should be used inside eventmachine
  class WebhookForwarder
    attr_reader :url
    attr_reader :http_options

    VALID_URL = %r{^(https?://[^/]+)/?$}

    # Create a WebhookForwarder
    def initialize(url, http_options={})
      unless url =~ VALID_URL
        raise ArgumentError, "Invalid url \"#{url}\", it should be in format: (https|http)://<host>(:<port>)?/?"
      end

      @url = url.match(VALID_URL)[1]
      @http_options = http_options
    end

    # path - string, the path of the request
    # query - string, the query string
    # headers - Hash, the header of the request
    # body - String, the body of the request
    def post(path, query, headers, body)
      EventMachine::HttpRequest.new(url, http_options).post :head => headers, :path => path, :query => query, :body => body
    end
  end
end