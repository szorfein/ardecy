# frozen_string_literal: true

require 'display'
require_relative 'harden/sysctl'

module Ardecy
  module Harden
    extend Display

    def self.sysctl(args)
      sysctl_kernel(args)
      puts
      sysctl_network(args)
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
      conf = '/etc/sysctl.d/ardecy_kernel.conf'
      puts if args[:audit]
      puts " ===> Applying at #{conf}..."
      puts
      kernel_correct_show Sysctl::KERNEL
      Sysctl::KERNEL << "\n"
      if Dir.exist? '/etc/sysctl.d/'
        File.write(conf, Sysctl::KERNEL.join("\n"), mode: 'w', chmod: 0644)
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
      conf = '/etc/sysctl.d/ardecy_network.conf'
      puts if args[:audit]
      puts " ===> Applying at #{conf}..."
      puts
      kernel_correct_show Sysctl::NETWORK
      Sysctl::NETWORK << "\n"
      if Dir.exist? '/etc/sysctl.d/'
        File.write(conf, Sysctl::NETWORK.join("\n"), mode: 'w', chmod: 0644)
      else
        puts '[-] Directory /etc/sysctl.d/ no found.'
      end
    end
  end
end
