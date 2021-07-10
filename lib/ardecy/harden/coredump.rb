# frozen_string_literal: true

module Ardecy
  module Harden
    # Core dumps contain the recorded memory of a program at a specific time.
    # Usually when that program has crashed.
    module CoreDump
      def self.exec(args)
        CoreDump::KernelCorePattern.new(args).x
        CoreDump::SecLimit.new(args).x
        CoreDump::FsSuidDumpable.new(args).x
        puts " ===> Corrected" if args[:fix]
      end

      # To disable CoreDump via sysctl
      class KernelCorePattern < Sysctl::SysKern
        def initialize(args)
          @file = '/proc/sys/kernel/core_pattern=|/bin/false'
          @line = 'kernel.core_pattern=|/bin/false'
          super
          @tab = 2
        end
      end

      class SecLimit < FileEdit
        def initialize(args)
          super
          @file = '/etc/security/limits.conf'
          @content = '* hard core 0'
          @edit = '* hard core'
          @tab = 1
        end
      end

      # Block program that run with elevated privileges.
      class FsSuidDumpable < Sysctl::SysKern
        def initialize(args)
          @file = '/proc/sys/fs/suid_dumpable'
          @line = 'fs.suid_dumpable'
          super
          @tab = 4
        end
      end
    end
  end
end
