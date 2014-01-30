require_relative '../lib/localhook'
require 'yajl'

describe Localhook::StreamParser do
  context "-handle_line" do
    it "call on_id with the id" do
      id = "hello"
      subject.should_receive(:on_id).with(id)
      subject.handle_line("id: #{id}")
    end

    it "call on_data with the parsed json message" do
      message = {"hello" => "world"}
      message_json = Yajl::Encoder.encode(message)

      subject.should_receive(:on_data).with(message)
      subject.handle_line("data: #{message_json}")
    end
  end
end