require_relative 'ardecy/version'
require_relative 'ardecy/options'
require_relative 'ardecy/harden'
require_relative 'ardecy/privacy'
require_relative 'ardecy/guard'

module Ardecy
  class Main
    def initialize(args)
      @cli = Options.new(args).options
      show_intent
      permission
    end

    def scan
      Harden.sysctl({
        :audit => @cli[:audit],
        :fix  => @cli[:fix]
      })
    end

    def bye
      puts
      puts " -[ Bye - Ardecy v." + Ardecy::VERSION + " ]- "
      exit
    end

    def permission
      if @cli[:fix]
        Ardecy::Guard.perm
      end
    end

    def show_intent
      audit = @cli[:audit] ||= false
      fixing = @cli[:fix] ||= false
      puts
      if audit || fixing
        print " ====> "
        print "Audit " if audit
        print "Fixing " if fixing
        print "System"
        puts
      end
      puts
    end
  end
end

