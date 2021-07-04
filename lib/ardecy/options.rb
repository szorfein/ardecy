require 'optparse'

module Ardecy
  class Options
    attr_reader :options

    def initialize(args)
      @options = {}
      parse(args)
    end

    def parse(args)
      OptionParser.new do |opts|
        opts.on("--audit", "Perform local security scan.") do
          @options[:audit] = true
        end

        begin
          opts.parse!(args)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, '\n', opts
          exit 1
        end
      end
    end
  end
end
