# frozen_string_literal: true

require 'display'

module Ardecy
  module Harden
    module Perms
      class DirCheck
        include Display

        def initialize(args)
          @args = args
          @res = 'OK'
          @exp = 0755
          @tab = 2
        end

        def x
          scan
          fix
        end

        def scan
          return unless Dir.exist? @name

          perm = File.stat(@name).mode & 07777
          @line = "Permission on #{@name}"

          perm_show(@line, @exp) if @args[:audit]
          @res = 'FAIL' if perm > @exp
          @tab ? result(@res, @tab) : result(@res) if @args[:audit]
        end

        def fix
          return unless @args[:fix]

          File.chmod @exp, @name unless @res =~ /OK/
        end
      end

      module Directory
        def self.exec(args)
          Directory::Home.new(args).x
          Directory::CronDaily.new(args).x
          Directory::Boot.new(args).x
          Directory::UsrSrc.new(args).x
          Directory::LibMod.new(args).x
          Directory::UsrLibMod.new(args).x
          puts " ===> Permission Corrected." if args[:fix]
        end

        class Home < Perms::DirCheck
          def initialize(args)
            super
            @exp = 0700
          end

          def x
            Dir.glob('/home/*').each { |d|
              @name = d
              scan
              fix
            }
          end
        end

        class CronDaily < Perms::DirCheck
          def initialize(args)
            super
            @name = '/etc/cron.daily'
            @exp = 0700
          end
        end

        class Boot < Perms::DirCheck
          def initialize(args)
            super
            @name = '/boot'
            @exp = 0700
            @tab = 3
          end
        end

        class UsrSrc < Perms::DirCheck
          def initialize(args)
            super
            @name = '/usr/src'
            @exp = 0700
          end
        end

        class LibMod < Perms::DirCheck
          def initialize(args)
            super
            @name = '/lib/modules'
            @exp = 0700
          end
        end

        class UsrLibMod < Perms::DirCheck
          def initialize(args)
            super
            @name = '/usr/lib/modules'
            @exp = 0700
          end
        end
      end
    end
  end
end
