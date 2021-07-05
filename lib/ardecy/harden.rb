require 'display'
require_relative 'harden/sysctl'

module Ardecy
  module Harden
    extend Display

    def self.sysctl(args)
      title "Kernel Hardening"

      Sysctl::KPointer.new(args).x
      Sysctl::Dmesg.new(args).x
      Sysctl::Printk.new(args).x
      Sysctl::BpfDisabled.new(args).x
      Sysctl::BpfJitHarden.new(args).x

      if args[:fix]
        puts if args[:audit]
        puts " ===> Correcting..."
        puts
        kernel_correct_show Sysctl::KERNEL
      end
    end
  end
end
