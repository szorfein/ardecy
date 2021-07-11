# frozen_string_literal: true

require 'display'
require_relative 'harden/sysctl'
require_relative 'harden/modules'
require_relative 'harden/perms'
require_relative 'harden/mountpoint'
require_relative 'harden/cmdline'
require_relative 'harden/coredump'

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
      Modules::Blacklist.exec(args)
    end

    def self.write_ardecy_blacklist(args)
      return unless args[:fix]

      if Dir.exist? '/etc/modprobe.d/'
        conf = '/etc/modprobe.d/ardecy_blacklist.conf'
        writing(conf, Modules::BLACKLIST, args[:audit])
      else
        puts "[-] Directory /etc/modprobe.d/ no found..."
      end
    end

    def self.permissions(args)
      puts
      title 'Directory Permissions'
      Perms::Directory.exec(args)
    end

    def self.mountpoint(args)
      puts
      title 'Mountpoint'
      Mountpoint.exec(args)
    end

    def self.cmdline(args)
      puts
      title 'Kernel Cmdline'
      CmdLine.exec(args)
    end

    def self.coredump(args)
      puts
      title 'Coredump'
      CoreDump.exec(args)

      # Added as last step
      puts
      write_ardecy_blacklist(args)
      write_ardecy_kernel(args)
    end

    def self.writing(file, list, audit = false)
      return unless list.length >= 1

      puts if audit
      puts " ===> Applying at #{file}..."
      display_fix_list list

      list << "\n"
      list_f = list.freeze

      File.write(file, list_f.join("\n"), mode: 'w', chmod: 644)
    end

    def self.sysctl_kernel(args)
      title 'Kernel Hardening'
      Sysctl::Kernel.exec(args)
    end

    def self.write_ardecy_kernel(args)
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
      Sysctl::Network.exec(args)
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
