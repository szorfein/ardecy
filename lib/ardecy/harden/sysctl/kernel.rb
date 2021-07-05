module Ardecy
  module Harden
    module Sysctl
      module Kernel
        class KPointer < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/kptr_restrict'
            @exp = '2'
            @res = 'FALSE'
            @line = 'kernel.kptr_restrict'
            @args = args
          end
        end

        class Dmesg < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/dmesg_restrict'
            @exp = '1'
            @res = 'FALSE'
            @line = 'kernel.dmesg_restrict'
            @args = args
          end
        end

        class Printk < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/printk'
            @exp = '3 3 3 3'
            @res = 'FALSE'
            @line = 'kernel.printk'
            @args = args
          end

          def scan
            kernel_show(@line, @exp) if @args[:audit]
            value = File.read(@file).chomp
            if value =~ /3\s+3\s+3\s+3/
              @res = 'OK'
            end
            kernel_res(@res) if @args[:audit]
          end
        end

        class BpfDisabled < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/unprivileged_bpf_disabled'
            @exp = '1'
            @res = 'FALSE'
            @line = 'kernel.unprivileged_bpf_disabled'
            @tab = 2
            @args = args
          end
        end

        class BpfJitHarden < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/net/core/bpf_jit_harden'
            @exp = '2'
            @res = 'FALSE'
            @line = 'net.core.bpf_jit_harden'
            @args = args
          end
        end

        class LdiskAutoload < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/dev/tty/ldisc_autoload'
            @exp = '0'
            @res = 'FALSE'
            @line = 'dev.tty.ldisc_autoload'
            @args = args
          end
        end

        class UserFaultFd < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/vm/unprivileged_userfaultfd'
            @exp = '0'
            @res = 'FALSE'
            @line = 'vm.unprivileged_userfaultfd'
            @args = args
            @tab = 2
          end
        end

        class KExecLoadDisabled < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/kexec_load_disabled'
            @exp = '1'
            @res = 'FALSE'
            @line = 'kernel.kexec_load_disabled'
            @args = args
          end
        end

        class SysRQ < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/sysrq'
            @exp = '0'
            @res = 'FALSE'
            @line = 'kernel.sysrq'
            @args = args
            @tab = 4
          end
        end

        class UsernsClone < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/unprivileged_userns_clone'
            @exp = '0'
            @res = 'FALSE'
            @line = 'unprivileged_userns_clone'
            @args = args
          end
        end

        class MaxUserNameSpace < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/user/max_user_namespaces'
            @exp = '0'
            @res = 'FALSE'
            @line = 'user.max_user_namespaces'
            @args = args
          end
        end

        class PerfEventParanoid < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/perf_event_paranoid'
            @exp = '3'
            @res = 'FALSE'
            @line = 'kernel.perf_event_paranoid'
            @args = args
          end
        end
      end
    end
  end
end
