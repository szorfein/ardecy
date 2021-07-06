# frozen_string_literal: true

require 'display'
require_relative 'harden/sysctl'
require_relative 'harden/modules'

module Ardecy
  module Harden
    extend Display

    def self.sysctl(args)
      sysctl_kernel(args)
      puts
      sysctl_network(args)
    end

    def self.modules(args)
      puts
      title 'Kernel Modules'

      Modules::Blacklist::Dccp.new(args).x
      Modules::Blacklist::Sctp.new(args).x
      Modules::Blacklist::Rds.new(args).x
      Modules::Blacklist::Tipc.new(args).x
      Modules::Blacklist::NHdlc.new(args).x
      Modules::Blacklist::Ax25.new(args).x
      Modules::Blacklist::Netrom.new(args).x
      Modules::Blacklist::X25.new(args).x
      Modules::Blacklist::Rose.new(args).x
      Modules::Blacklist::Decnet.new(args).x
      Modules::Blacklist::Econet.new(args).x
      Modules::Blacklist::Af802154.new(args).x
      Modules::Blacklist::Ipx.new(args).x
      Modules::Blacklist::Appletalk.new(args).x
      Modules::Blacklist::Psnap.new(args).x
      Modules::Blacklist::P8023.new(args).x
      Modules::Blacklist::P8022.new(args).x
      Modules::Blacklist::Can.new(args).x
      Modules::Blacklist::Atm.new(args).x
      return unless args[:fix]

      if Dir.exist? '/etc/modprobe.d/'
        conf = '/etc/modprobe.d/ardecy_blacklist.conf'
        writing(conf, Modules::BLACKLIST, args[:audit])
      else
        puts "[-] Directory /etc/modprobe.d/ no found..."
      end
    end

    def self.writing(file, list, audit = false)
      return unless list.length >= 2

      puts if audit
      puts " ===> Applying at #{file}..."
      display_fix_list list

      list << "\n"
      list_f = list.freeze

      File.write(file, list_f.join("\n"), mode: 'w', chmod: 644)
    end

    def self.sysctl_kernel(args)
      title 'Kernel Hardening'

      Sysctl::Kernel::KPointer.new(args).x
      Sysctl::Kernel::Dmesg.new(args).x
      Sysctl::Kernel::Printk.new(args).x
      Sysctl::Kernel::BpfDisabled.new(args).x
      Sysctl::Kernel::BpfJitHarden.new(args).x
      Sysctl::Kernel::LdiskAutoload.new(args).x
      Sysctl::Kernel::UserFaultFd.new(args).x
      Sysctl::Kernel::KExecLoadDisabled.new(args).x
      Sysctl::Kernel::SysRQ.new(args).x
      Sysctl::Kernel::UsernsClone.new(args).x
      Sysctl::Kernel::MaxUserNameSpace.new(args).x
      Sysctl::Kernel::PerfEventParanoid.new(args).x
      Sysctl::Kernel::YamaPtrace.new(args).x
      Sysctl::Kernel::VmMmapRndBits.new(args).x
      Sysctl::Kernel::VmMmapRndCompatBits.new(args).x
      Sysctl::Kernel::FsProtectedSymlinks.new(args).x
      Sysctl::Kernel::FsProtectedHardlinks.new(args).x
      Sysctl::Kernel::FsProtectedFifos.new(args).x
      Sysctl::Kernel::FsProtectedRegular.new(args).x

      return unless args[:fix]

      if Dir.exist? '/etc/sysctl.d/'
        conf = '/etc/sysctl.d/ardecy_kernel.conf'
        writing(conf, Sysctl::KERNEL, args[:audit])
      else
        puts '[-] Directory /etc/sysctl.d/ no found.'
      end
    end

    def self.sysctl_network(args)
      title 'Network Hardening'

      Sysctl::Network::TcpSynCookie.new(args).x
      Sysctl::Network::RFC1337.new(args).x
      Sysctl::Network::AllRpFilter.new(args).x
      Sysctl::Network::DefaultRpFilter.new(args).x
      Sysctl::Network::AllAcceptRedirects.new(args).x
      Sysctl::Network::DefaultAcceptRedirects.new(args).x
      Sysctl::Network::AllSecureRedirects.new(args).x
      Sysctl::Network::DefaultSecureRedirects.new(args).x
      Sysctl::Network::Ipv6AllAcceptRedirects.new(args).x
      Sysctl::Network::Ipv6DefaultAcceptRedirects.new(args).x
      Sysctl::Network::AllSendRedirects.new(args).x
      Sysctl::Network::DefaultSendRedirects.new(args).x
      Sysctl::Network::IcmpEchoIgnoreAll.new(args).x
      Sysctl::Network::AllAcceptSourceRoute.new(args).x
      Sysctl::Network::DefaultAcceptSourceRoute.new(args).x
      Sysctl::Network::Ipv6AllAcceptSourceRoute.new(args).x
      Sysctl::Network::Ipv6DefaultAcceptSourceRoute.new(args).x
      Sysctl::Network::Ipv6ConfAllAcceptRa.new(args).x
      Sysctl::Network::Ipv6ConfDefaultAcceptRa.new(args).x
      Sysctl::Network::TcpSack.new(args).x
      Sysctl::Network::TcpDSack.new(args).x
      Sysctl::Network::TcpFack.new(args).x

      return unless args[:fix]

      if Dir.exist? '/etc/sysctl.d/'
        conf = '/etc/sysctl.d/ardecy_network.conf'
        writing(conf, Sysctl::NETWORK, args[:audit])
      else
        puts '[-] Directory /etc/sysctl.d/ no found.'
      end
    end
  end
end
