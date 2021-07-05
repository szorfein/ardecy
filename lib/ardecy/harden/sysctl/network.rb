module Ardecy
  module Harden
    module Sysctl
      module Network
        class TcpSynCookie < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/tcp_syncookies'
             @exp = '1'
             @res = 'FALSE'
             @line = 'net.ipv4.tcp_syncookies'
             @args = args
           end
        end

        class RFC1337 < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/tcp_rfc1337'
             @exp = '1'
             @res = 'FALSE'
             @line = 'net.ipv4.tcp_rfc1337'
             @args = args
           end
        end

        class AllRpFilter < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/conf/all/rp_filter'
             @exp = '1'
             @res = 'FALSE'
             @line = 'net.ipv4.conf.all.rp_filter'
             @args = args
             @tab = 2
           end
        end

        class DefaultRpFilter < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/conf/default/rp_filter'
             @exp = '1'
             @res = 'FALSE'
             @line = 'net.ipv4.conf.default.rp_filter'
             @args = args
             @tab = 2
           end
        end

        class AllAcceptRedirects < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/conf/all/accept_redirects'
             @exp = '0'
             @res = 'FALSE'
             @line = 'net.ipv4.conf.all.accept_redirects'
             @args = args
             @tab = 2
           end
        end

        class DefaultAcceptRedirects < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/conf/default/accept_redirects'
             @exp = '0'
             @res = 'FALSE'
             @line = 'net.ipv4.conf.default.accept_redirects'
             @args = args
             @tab = 1
           end
        end

        class AllSecureRedirects < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/conf/all/secure_redirects'
             @exp = '0'
             @res = 'FALSE'
             @line = 'net.ipv4.conf.all.secure_redirects'
             @args = args
             @tab = 2
           end
        end

        class DefaultSecureRedirects < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/conf/default/secure_redirects'
             @exp = '0'
             @res = 'FALSE'
             @line = 'net.ipv4.conf.default.secure_redirects'
             @args = args
             @tab = 1
           end
        end

        class Ipv6AllAcceptRedirects < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv6/conf/all/accept_redirects'
             @exp = '0'
             @res = 'FALSE'
             @line = 'net.ipv6.conf.all.accept_redirects'
             @args = args
             @tab = 2
           end
        end
        
        class Ipv6DefaultAcceptRedirects < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv6/conf/default/accept_redirects'
             @exp = '0'
             @res = 'FALSE'
             @line = 'net.ipv6.conf.default.accept_redirects'
             @args = args
             @tab = 1
           end
        end

        class AllSendRedirects < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/conf/all/send_redirects'
             @exp = '0'
             @res = 'FALSE'
             @line = 'net.ipv4.conf.all.send_redirects'
             @args = args
             @tab = 2
           end
        end

        class DefaultSendRedirects < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/conf/default/send_redirects'
             @exp = '0'
             @res = 'FALSE'
             @line = 'net.ipv4.conf.default.send_redirects'
             @args = args
             @tab = 1
           end
        end

        class IcmpEchoIgnoreAll < Sysctl::SysNet
           def initialize(args)
             @file = '/proc/sys/net/ipv4/icmp_echo_ignore_all'
             @exp = '0'
             @res = 'FALSE'
             @line = 'net.ipv4.icmp_echo_ignore_all'
             @args = args
             @tab = 2
           end
        end
      end
    end
  end
end
