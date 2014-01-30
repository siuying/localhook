require_relative '../lib/localhook'
require 'yajl'

describe Localhook::EventSource do  
  context "-initialize" do
    it "set url via base_url and token parameter" do
      forwarder = Localhook::EventSource.new("http://localhost:8080", double(:forwarder), "t")
      expect(forwarder.url).to eq("http://localhost:8080/_localhook?token=t")

      forwarder = Localhook::EventSource.new("http://localhost:8080/", double(:forwarder), "t")
      expect(forwarder.url).to eq("http://localhost:8080/_localhook?token=t")
    end
  end

  context "-data_parsed" do
    let(:forwarder) { double(:forwarder) }
    subject { Localhook::EventSource.new("http://www.google.com", forwarder, "1") }

    it "call forwarder.post() when parsed action 'post'" do
      message = {:action => "post", 
        :query_string => "a=1", 
        :path => "/a/b", 
        :body => "{}", 
        :headers => [["User-Agent", "rspec"]]
      }

      expect(forwarder).to receive(:post).with("/a/b", "a=1", {"User-Agent" => "rspec"}, "{}")
      subject.data_parsed(message)
    end
  end
end