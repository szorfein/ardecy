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
        def self.exec(args)
          Blacklist::Dccp.new(args).x
          Blacklist::Sctp.new(args).x
          Blacklist::Rds.new(args).x
          Blacklist::Tipc.new(args).x
          Blacklist::NHdlc.new(args).x
          Blacklist::Ax25.new(args).x
          Blacklist::Netrom.new(args).x
          Blacklist::X25.new(args).x
          Blacklist::Rose.new(args).x
          Blacklist::Decnet.new(args).x
          Blacklist::Econet.new(args).x
          Blacklist::Af802154.new(args).x
          Blacklist::Ipx.new(args).x
          Blacklist::Appletalk.new(args).x
          Blacklist::Psnap.new(args).x
          Blacklist::P8023.new(args).x
          Blacklist::P8022.new(args).x
          Blacklist::Can.new(args).x
          Blacklist::Atm.new(args).x

          # Filesystem
          Blacklist::CramFs.new(args).x
          Blacklist::FreevxFs.new(args).x
          Blacklist::Jffs2.new(args).x
          Blacklist::HFs.new(args).x
          Blacklist::HFsplus.new(args).x
          Blacklist::SquashFs.new(args).x
          Blacklist::Udf.new(args).x

          Blacklist::Vivid.new(args).x
          Blacklist::UvcVideo.new(args).x
          puts " ===> Corrected" if args[:fix]
        end

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

        class CramFs < Modules::Drop
          def initialize(args)
            @name = 'cramfs'
            super
          end
        end

        class FreevxFs < Modules::Drop
          def initialize(args)
            @name = 'freevxfs'
            @tab = 2
            super
          end
        end

        class Jffs2 < Modules::Drop
          def initialize(args)
            @name = 'jffs2'
            super
          end
        end

        class HFs < Modules::Drop
          def initialize(args)
            @name = 'hfs'
            super
          end
        end

        class HFsplus < Modules::Drop
          def initialize(args)
            @name = 'hfsplus'
            @tab = 2
            super
          end
        end

        class SquashFs < Modules::Drop
          def initialize(args)
            @name = 'spuashfs'
            @tab = 2
            super
          end
        end

        class Udf < Modules::Drop
          def initialize(args)
            @name = 'udf'
            super
          end
        end

        class Vivid < Modules::Drop
          def initialize(args)
            @name = 'vivid'
            super
          end
        end

        # Webcam
        class UvcVideo < Modules::Drop
          def initialize(args)
            @name = 'uvcvideo'
            @tab = 2
            super
          end
        end
      end
    end
  end
end
