require 'yajl'

module Localhook
  class StreamParser
    attr_reader :parser

    def initialize
      @parser = Yajl::Parser.new
    end

    def parse_line(line)
      match = line.match(/^([a-zA-Z]+):[ \t]*(.+)/)
      if match
        name = match[1]
        message = match[2]
        case name
        when "id"
          on_id(message)
        when "data"
          data = parser.parse(message)
          on_data(data)
        end
      end
    end

    def on_data(data)
      puts "data #{data}"
    end

    def on_id(id)
      puts "id #{id}"
    end
  end
end 