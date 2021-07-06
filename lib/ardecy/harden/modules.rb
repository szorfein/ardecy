# frozen_string_literal: true

require 'display'

module Ardecy
  module Harden
    module Modules
      BLACKLIST = []

      class Drop
        include Display

        def initialize(args)
          @res = 'OK'
          @args = args
        end

        def quit_unless_modules
          unless File.exist? '/proc/modules'
            warn '/proc/modules no found'
            exit 1
          end
        end

        def research_found
          quit_unless_modules

          File.readlines('/proc/modules').each do |l|
            return true if l =~ /^#{@name}/
          end
          false
        end

        def x
          @res = 'FAIL' if research_found
          if @args[:audit]
            show_bad_mod(@name)
            @tab ? result(@res, @tab) : result(@res)
          end
          fix
        end

        def fix
          return if @res =~ /OK/
          BLACKLIST << "install #{@name} /bin/false"
        end
      end

      module Blacklist
        class Dccp < Modules::Drop
          def initialize(args)
            @name = 'dccp'
            super
          end
        end

        class Sctp < Modules::Drop
          def initialize(args)
            @name = 'sctp'
            super
          end
        end

        class Rds < Modules::Drop
          def initialize(args)
            @name = 'rds'
            super
          end
        end

        class Tipc < Modules::Drop
          def initialize(args)
            @name = 'tipc'
            super
          end
        end

        class NHdlc < Modules::Drop
          def initialize(args)
            @name = 'n-hdlc'
            super
          end
        end

        class Ax25 < Modules::Drop
          def initialize(args)
            @name = 'ax25'
            super
          end
        end

        class Netrom < Modules::Drop
          def initialize(args)
            @name = 'netrom'
            super
          end
        end

        class X25 < Modules::Drop
          def initialize(args)
            @name = 'x25'
            super
          end
        end

        class Rose < Modules::Drop
          def initialize(args)
            @name = 'rose'
            super
          end
        end

        class Decnet < Modules::Drop
          def initialize(args)
            @name = 'decnet'
            super
          end
        end

        class Econet < Modules::Drop
          def initialize(args)
            @name = 'econet'
            super
          end
        end

        class Af802154 < Modules::Drop
          def initialize(args)
            @name = 'af_802154'
            @tab = 2
            super
          end
        end

        class Ipx < Modules::Drop
          def initialize(args)
            @name = 'ipx'
            super
          end
        end

        class Appletalk < Modules::Drop
          def initialize(args)
            @name = 'appletalk'
            @tab = 2
            super
          end
        end

        class Psnap < Modules::Drop
          def initialize(args)
            @name = 'psnap'
            super
          end
        end

        class P8023 < Modules::Drop
          def initialize(args)
            @name = 'p8023'
            super
          end
        end

        class P8022 < Modules::Drop
          def initialize(args)
            @name = 'p8022'
            super
          end
        end

        class Can < Modules::Drop
          def initialize(args)
            @name = 'can'
            super
          end
        end

        class Atm < Modules::Drop
          def initialize(args)
            @name = 'atm'
            super
          end
        end
      end
    end
  end
end
