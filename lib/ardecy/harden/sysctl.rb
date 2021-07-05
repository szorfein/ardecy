require 'display'

module Ardecy
  module Harden
    module Sysctl
      KERNEL = []

      class SysKern
        include Display

        def scan
          kernel_show(@line, @exp) if @audit
          if File.exist? @file
            if File.readable? @file
              value = File.read(@file).chomp 
              @res = value.to_s === @exp ? 'OK' : 'FALSE'
            else
              @res = "PROTECTED"
            end
          else
            @res = 'NO FOUND'
          end
          if @notab
            kernel_res(@res, 1) if @audit
          else
            kernel_res(@res) if @audit
          end
        end

        def fix
          if @res != 'OK' && @res != 'PROTECTED'
            KERNEL << "#{@line} = #{@exp}"
          end
        end

        def x
          scan
          fix
        end
      end

      class KPointer < SysKern
        def initialize(args)
          @file = '/proc/sys/kernel/kptr_restrict'
          @exp = '2'
          @res = 'FALSE'
          @line = 'kernel.kptr_restrict'
          @audit = args[:audit] ||= false
        end
      end

      class Dmesg < SysKern
        def initialize(args)
          @file = '/proc/sys/kernel/dmesg_restrict'
          @exp = '1'
          @res = 'FALSE'
          @line = 'kernel.dmesg_restrict'
          @audit = args[:audit] ||= false
        end
      end

      class Printk < SysKern
        def initialize(args)
          @file = '/proc/sys/kernel/printk'
          @exp = '3 3 3 3'
          @res = 'FALSE'
          @line = 'kernel.printk'
          @audit = args[:audit] ||= false
        end

        def scan
          kernel_show(@line, @exp) if @audit
          value = File.read(@file).chomp
          if value =~ /3\s+3\s+3\s+3/
            @res = 'OK'
          end
          kernel_res(@res) if @audit
        end
      end

      class BpfDisabled < SysKern
        def initialize(args)
          @file = '/proc/sys/kernel/unprivileged_bpf_disabled'
          @exp = '1'
          @res = 'FALSE'
          @line = 'kernel.unprivileged_bpf_disabled'
          @notab = true
          @audit = args[:audit] ||= false
        end
      end

      class BpfJitHarden < SysKern
        def initialize(args)
          @file = '/proc/sys/net/core/bpf_jit_harden'
          @exp = '2'
          @res = 'FALSE'
          @line = 'net.core.bpf_jit_harden'
          @audit = args[:audit] ||= false
        end
      end
    end
  end
end
