# frozen_string_literal: true

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

        opts.on('--path-bootctl PATH', String, 'Path for bootctl, esp should be mounted') do |f|
          raise "No file #{f}" unless File.exists? f

          @options[:bootctl] = f
        end

        opts.on('--path-syslinux PATH', String, 'Path for syslinux if not /boot/syslinux/syslinux.cfg') do |f|
          raise "No file #{f}" unless File.exists? f

          @options[:syslinux] = f
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
