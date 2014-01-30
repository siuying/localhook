require_relative '../lib/localhook'
require 'yajl'

describe Localhook::WebhookForwarder do
  context "initialize" do
    it "accept valid url" do
      forwarder = Localhook::WebhookForwarder.new("http://localhost:8080")
      expect(forwarder.url).to eq("http://localhost:8080")

      forwarder = Localhook::WebhookForwarder.new("http://localhost:8080/")
      expect(forwarder.url).to eq("http://localhost:8080")
    end
    
    it "merge input options with default options" do
      options = {a: 1}
      forwarder = Localhook::WebhookForwarder.new("http://localhost:8080", options)
      expect(forwarder.http_options).to eq(Localhook::WebhookForwarder::DEFAULT_OPTIONS.merge(options))
    end

    it "raise exception for invalid url" do
      expect {
        Localhook::WebhookForwarder.new("http://localhost:8080/a/b")
      }.to raise_error(ArgumentError)
    end
  end

  context "post" do
    subject { Localhook::WebhookForwarder.new("http://localhost:8080") }
    it "forward request to remote server via em" do
      params  = {head: {}, path: "/a/b", query: "", body: ""}
      request = double(:request)
      expect(request).to receive(:post).with(params).and_return(request)
      expect(request).to receive(:callback)
      expect(request).to receive(:errback)
      expect(EventMachine::HttpRequest).to receive(:new).with(subject.url, subject.http_options).and_return(request)
      subject.post("/a/b", "", {}, "")
    end
  end
end