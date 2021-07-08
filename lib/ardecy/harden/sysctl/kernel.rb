# frozen_string_literal: true

module Ardecy
  module Harden
    module Sysctl
      module Kernel
        def self.exec(args)
          Kernel::KPointer.new(args).x
          Kernel::Dmesg.new(args).x
          Kernel::Printk.new(args).x
          Kernel::BpfDisabled.new(args).x
          Kernel::BpfJitHarden.new(args).x
          Kernel::LdiskAutoload.new(args).x
          Kernel::UserFaultFd.new(args).x
          Kernel::KExecLoadDisabled.new(args).x
          Kernel::SysRQ.new(args).x
          Kernel::UsernsClone.new(args).x
          Kernel::MaxUserNameSpace.new(args).x
          Kernel::PerfEventParanoid.new(args).x
          Kernel::YamaPtrace.new(args).x
          Kernel::VmMmapRndBits.new(args).x
          Kernel::VmMmapRndCompatBits.new(args).x
          Kernel::FsProtectedSymlinks.new(args).x
          Kernel::FsProtectedHardlinks.new(args).x
          Kernel::FsProtectedFifos.new(args).x
          Kernel::FsProtectedRegular.new(args).x
          Kernel::FsSuidDumpable.new(args).x
        end

        class KPointer < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/kptr_restrict'
            @line = 'kernel.kptr_restrict'
            super
            @exp = '2'
          end
        end

        class Dmesg < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/dmesg_restrict'
            @line = 'kernel.dmesg_restrict'
            super
            @exp = '1'
          end
        end

        class Printk < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/printk'
            @line = 'kernel.printk'
            @tab = 6
            super
            @exp = '3 3 3 3'
          end

          def scan
            kernel_show(@line, @exp) if @args[:audit]
            value = File.read(@file).chomp
            @res = 'OK' if value =~ /3\s+3\s+3\s+3/
            result(@res) if @args[:audit]
          end
        end

        class BpfDisabled < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/unprivileged_bpf_disabled'
            @line = 'kernel.unprivileged_bpf_disabled'
            @tab = 2
            super
            @exp = '1'
          end
        end

        class BpfJitHarden < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/net/core/bpf_jit_harden'
            @line = 'net.core.bpf_jit_harden'
            super
            @exp = '2'
          end
        end

        class LdiskAutoload < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/dev/tty/ldisc_autoload'
            @line = 'dev.tty.ldisc_autoload'
            super
          end
        end

        class UserFaultFd < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/vm/unprivileged_userfaultfd'
            @line = 'vm.unprivileged_userfaultfd'
            @tab = 2
            super
          end
        end

        class KExecLoadDisabled < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/kexec_load_disabled'
            @line = 'kernel.kexec_load_disabled'
            super
            @exp = '1'
          end
        end

        class SysRQ < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/sysrq'
            @line = 'kernel.sysrq'
            @tab = 4
            super
          end
        end

        class UsernsClone < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/unprivileged_userns_clone'
            @line = 'unprivileged_userns_clone'
            super
          end
        end

        class MaxUserNameSpace < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/user/max_user_namespaces'
            @line = 'user.max_user_namespaces'
            super
          end
        end

        class PerfEventParanoid < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/perf_event_paranoid'
            @line = 'kernel.perf_event_paranoid'
            super
            @exp = '3'
          end
        end

        class YamaPtrace < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/kernel/yama/ptrace_scope'
            @line = 'kernel.yama.ptrace_scope'
            super
            @exp = '2'
          end
        end

        class VmMmapRndBits < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/vm/mmap_rnd_bits'
            @line = 'vm.mmap_rnd_bits'
            @tab = 4
            super
            @exp = '32'
          end
        end

        class VmMmapRndCompatBits < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/vm/mmap_rnd_compat_bits'
            @line = 'vm.mmap_rnd_compat_bits'
            super
            @exp = '16'
          end
        end

        class FsProtectedSymlinks < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/fs/protected_symlinks'
            @line = 'fs.protected_symlinks'
            super
            @exp = '1'
          end
        end

        class FsProtectedHardlinks < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/fs/protected_hardlinks'
            @line = 'fs.protected_hardlinks'
            super
            @exp = '1'
          end
        end

        class FsProtectedFifos < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/fs/protected_fifos'
            @line = 'fs.protected_fifos'
            @tab = 4
            super
            @exp = '2'
          end
        end

        class FsProtectedRegular < Sysctl::SysKern
          def initialize(args)
            @file = '/proc/sys/fs/protected_regular'
            @line = 'fs.protected_regular'
            super
            @exp = '2'
          end
        end

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
end
