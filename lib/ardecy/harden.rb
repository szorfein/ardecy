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
      title "Kernel Hardening"

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

      if args[:fix]
        conf = '/etc/sysctl.d/ardecy_kernel.conf'
        puts if args[:audit]
        puts " ===> Applying at #{conf}..."
        puts
        kernel_correct_show Sysctl::KERNEL
        Sysctl::KERNEL << "\n"
        if Dir.exist? '/etc/sysctl.d/'
          File.write(conf, Sysctl::KERNEL.join("\n"), mode: 'w', chmod: 0644)
        else
          puts "[-] Directory /etc/sysctl.d/ no found."
        end
      end
    end

    def self.sysctl_network(args)
      title "Network Hardening"

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

      if args[:fix]
        conf = '/etc/sysctl.d/ardecy_network.conf'
        puts if args[:audit]
        puts " ===> Applying at #{conf}..."
        puts
        kernel_correct_show Sysctl::NETWORK
        Sysctl::NETWORK << "\n"
        if Dir.exist? '/etc/sysctl.d/'
          File.write(conf, Sysctl::NETWORK.join("\n"), mode: 'w', chmod: 0644)
        else
          puts "[-] Directory /etc/sysctl.d/ no found."
        end
      end
    end
  end
end
