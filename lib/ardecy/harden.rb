require_relative 'harden/sysctl'

module Ardecy
  module Harden
    def self.sysctl
      Sysctl::KPointer.new.x
      Sysctl::Dmesg.new.x
      Sysctl::Printk.new.x
      Sysctl::BpfDisabled.new.x
      Sysctl::BpfJitHarden.new.x

      puts
      puts " ===> Will correct"
      puts
      puts Sysctl::KERNEL
    end
  end
end
