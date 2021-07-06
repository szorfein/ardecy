# frozen_string_literal: true

module Ardecy
  module Harden
    module Sysctl
      module Network
        def self.exec(args)
          Network::TcpSynCookie.new(args).x
          Network::RFC1337.new(args).x
          Network::AllRpFilter.new(args).x
          Network::DefaultRpFilter.new(args).x
          Network::AllAcceptRedirects.new(args).x
          Network::DefaultAcceptRedirects.new(args).x
          Network::AllSecureRedirects.new(args).x
          Network::DefaultSecureRedirects.new(args).x
          Network::Ipv6AllAcceptRedirects.new(args).x
          Network::Ipv6DefaultAcceptRedirects.new(args).x
          Network::AllSendRedirects.new(args).x
          Network::DefaultSendRedirects.new(args).x
          Network::IcmpEchoIgnoreAll.new(args).x
          Network::AllAcceptSourceRoute.new(args).x
          Network::DefaultAcceptSourceRoute.new(args).x
          Network::Ipv6AllAcceptSourceRoute.new(args).x
          Network::Ipv6DefaultAcceptSourceRoute.new(args).x
          Network::Ipv6ConfAllAcceptRa.new(args).x
          Network::Ipv6ConfDefaultAcceptRa.new(args).x
          Network::TcpSack.new(args).x
          Network::TcpDSack.new(args).x
          Network::TcpFack.new(args).x
        end

        class TcpSynCookie < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/tcp_syncookies'
            @line = 'net.ipv4.tcp_syncookies'
            super
            @exp = '1'
          end
        end

        class RFC1337 < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/tcp_rfc1337'
            @line = 'net.ipv4.tcp_rfc1337'
            super
            @exp = '1'
          end
        end

        class AllRpFilter < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/conf/all/rp_filter'
            @line = 'net.ipv4.conf.all.rp_filter'
            @tab = 2
            super
            @exp = '1'
          end
        end

        class DefaultRpFilter < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/conf/default/rp_filter'
            @line = 'net.ipv4.conf.default.rp_filter'
            @tab = 2
            super
            @exp = '1'
          end
        end

        class AllAcceptRedirects < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/conf/all/accept_redirects'
            @line = 'net.ipv4.conf.all.accept_redirects'
            @tab = 2
            super
          end
        end

        class DefaultAcceptRedirects < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/conf/default/accept_redirects'
            @line = 'net.ipv4.conf.default.accept_redirects'
            @tab = 1
            super
          end
        end

        class AllSecureRedirects < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/conf/all/secure_redirects'
            @line = 'net.ipv4.conf.all.secure_redirects'
            @tab = 2
            super
          end
        end

        class DefaultSecureRedirects < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/conf/default/secure_redirects'
            @line = 'net.ipv4.conf.default.secure_redirects'
            @tab = 1
            super
          end
        end

        class Ipv6AllAcceptRedirects < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv6/conf/all/accept_redirects'
            @line = 'net.ipv6.conf.all.accept_redirects'
            @tab = 2
            super
          end
        end

        class Ipv6DefaultAcceptRedirects < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv6/conf/default/accept_redirects'
            @line = 'net.ipv6.conf.default.accept_redirects'
            @tab = 1
            super
          end
        end

        class AllSendRedirects < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/conf/all/send_redirects'
            @line = 'net.ipv4.conf.all.send_redirects'
            @tab = 2
            super
          end
        end

        class DefaultSendRedirects < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/conf/default/send_redirects'
            @line = 'net.ipv4.conf.default.send_redirects'
            @tab = 1
            super
          end
        end

        class IcmpEchoIgnoreAll < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/icmp_echo_ignore_all'
            @line = 'net.ipv4.icmp_echo_ignore_all'
            @tab = 2
            super
            @exp = '1'
          end
        end

        class AllAcceptSourceRoute < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/conf/all/accept_source_route'
            @line = 'net.ipv4.conf.all.accept_source_route'
            @tab = 1
            super
          end
        end

        class DefaultAcceptSourceRoute < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/conf/default/accept_source_route'
            @line = 'net.ipv4.conf.default.accept_source_route'
            @tab = 1
            super
          end
        end

        class Ipv6AllAcceptSourceRoute < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv6/conf/all/accept_source_route'
            @line = 'net.ipv6.conf.all.accept_source_route'
            @tab = 1
            super
          end
        end

        class Ipv6DefaultAcceptSourceRoute < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv6/conf/default/accept_source_route'
            @line = 'net.ipv6.conf.default.accept_source_route'
            @tab = 1
            super
          end
        end

        class Ipv6ConfAllAcceptRa < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv6/conf/all/accept_ra'
            @line = 'net.ipv6.conf.all.accept_ra'
            @tab = 2
            super
          end
        end

        class Ipv6ConfDefaultAcceptRa < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv6/conf/default/accept_ra'
            @line = 'net.ipv6.conf.default.accept_ra'
            @tab = 2
            super
          end
        end

        class TcpSack < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/tcp_sack'
            @line = 'net.ipv4.tcp_sack'
            @tab = 4
            super
          end
        end

        class TcpDSack < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/tcp_dsack'
            @line = 'net.ipv4.tcp_dsack'
            @tab = 4
            super
          end
        end

        class TcpFack < Sysctl::SysNet
          def initialize(args)
            @file = '/proc/sys/net/ipv4/tcp_fack'
            @line = 'net.ipv4.tcp_fack'
            @tab = 4
            super
          end
        end
      end
    end
  end
end
