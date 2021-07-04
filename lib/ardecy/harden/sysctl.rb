module Ardecy
  module Harden
    module Sysctl
      KERNEL = []

      def self.show(file, exp)
        print "  - #{file} (exp: #{exp})"
      end

      class SysKern
        def scan
          Sysctl.show(@file, @exp)
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
            puts " [ #{@res} ]"
          else
            puts "\t\t[ #{@res} ]"
          end
        end

        def fix
          if @res != 'OK'
            KERNEL << "#{@line} = #{@exp}"
          end
        end

        def x
          scan
          fix
        end
      end

      class KPointer < SysKern
        def initialize
          @file = '/proc/sys/kernel/kptr_restrict'
          @exp = '2'
          @res = 'FALSE'
          @line = 'kernel.kptr_restrict'
        end
      end

      class Dmesg < SysKern
        def initialize
          @file = '/proc/sys/kernel/dmesg_restrict'
          @exp = '1'
          @res = 'FALSE'
          @line = 'kernel.dmesg_restrict'
        end
      end

      class Printk < SysKern
        def initialize
          @file = '/proc/sys/kernel/printk'
          @exp = '3 3 3 3'
          @res = 'FALSE'
          @line = 'kernel.printk'
        end

        def scan
          Sysctl.show(@file, @exp)
          value = File.read(@file).chomp
          if value =~ /3\s+3\s+3\s+3/
            @res = 'OK'
          end
          puts "\t\t[ #{@res} ]"
        end
      end

      class BpfDisabled < SysKern
        def initialize
          @file = '/proc/sys/kernel/unprivileged_bpf_disabled'
          @exp = '1'
          @res = 'FALSE'
          @line = 'kernel.unprivileged_bpf_disabled'
          @notab = true
        end
      end

      class BpfJitHarden < SysKern
        def initialize
          @file = '/proc/sys/net/core/bpf_jit_harden'
          @exp = '2'
          @res = 'FALSE'
          @line = 'net.core.bpf_jit_harden'
        end
      end
    end
  end
end
