require_relative '../lib/localhook'

describe Localhook::EventSource do
  context "-initialize" do
    it "accept parameters" do
      argv = CLAide::ARGV.new(['http://mylocalhook.com', 'http://localhost:3000'])
      command = Localhook::Command.new(argv)

      expect(command.remote_server).to eq("http://mylocalhook.com")
      expect(command.local_server).to eq("http://localhost:3000")
    end
  end

  context "-run" do
    it "raise error on missing parameters" do
      argv = CLAide::ARGV.new(['http://mylocalhook.com'])
      command = Localhook::Command.new(argv)
      expect {
        command.run
      }.to raise_error
    end
  end
end