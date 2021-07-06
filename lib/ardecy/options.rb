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
        opts.on('--audit', 'Perform local security scan.') do
          @options[:audit] = true
        end

        opts.on('--fix', 'Fix problems.') do
          @options[:fix] = true
        end

        opts.on('-h', '--help', 'Show this message.') do
          puts opts
          exit
        end

        begin
          args.push('-h') if args.empty?
          opts.parse!(args)
        rescue OptionParser::ParseError => e
          warn e.message, "\n", opts
          exit 1
        end
      end
    end
  end
end
