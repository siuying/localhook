require_relative '../lib/localhook'
require 'yajl'

describe Localhook::EventSource do
  let(:forwarder) { double(:forwarder) }
  subject { Localhook::EventSource.new("http://www.google.com", forwarder) }

  context "-data_parsed" do
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