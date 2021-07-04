require_relative 'ardecy/version'
require_relative 'ardecy/options'
require_relative 'ardecy/harden'
require_relative 'ardecy/privacy'

module Ardecy
  class Main
    def initialize(args)
      @cli = Options.new(args).options
    end

    def scan
      return unless @cli[:audit]
      puts
      puts " ===> Scanning system"
      puts
      Harden.sysctl
    end

    def bye
      puts
      puts " -[ Bye - Ardecy v." + Ardecy::VERSION + " ]- "
      exit
    end
  end
end

