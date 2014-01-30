require_relative '../lib/localhook'
require 'yajl'

describe Localhook::WebhookForwarder do
  context "-initialize" do
    it "accept valid url" do
      forwarder = Localhook::WebhookForwarder.new("http://localhost:8080")
      expect(forwarder.url).to eq("http://localhost:8080")

      forwarder = Localhook::WebhookForwarder.new("http://localhost:8080/")
      expect(forwarder.url).to eq("http://localhost:8080")
    end
    
    it "accept options" do
      options = {a: 1}
      forwarder = Localhook::WebhookForwarder.new("http://localhost:8080", options)
      expect(forwarder.http_options).to eq(options)
    end

    it "raise exception for invalid url" do
      expect {
        Localhook::WebhookForwarder.new("http://localhost:8080/a/b")
      }.to raise_error(ArgumentError)
    end
  end
end