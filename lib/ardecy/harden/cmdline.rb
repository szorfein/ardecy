# frozen_string_literal: true

require 'display'
require 'nito'

module Ardecy
  module Harden
    module CmdLine
      def self.exec(args)
        SlabNoMerge.new(args).x
        SlubDebug.new(args).x
        InitOnAlloc.new(args).x
        InitOnFree.new(args).x
        PageAllocShuffle.new(args).x
      end

      class LineInc
        include Display
        include NiTo

        def initialize(args)
          @name = 'pti=on'
          @res = 'FAIL'
          @tab = 4
          @args = args
        end

        def x
          scan
          fix
        end

        def scan
          curr_line = File.readlines('/proc/cmdline')
          curr_line.each { |l| @res = 'OK' if l =~ /#{@name}/ }
          print "  - include #{@name}" if @args[:audit]
          @tab ? result(@res, @tab) : result(@res) if @args[:audit]
        end

        def fix
          return unless @args[:fix]
          return if @res =~ /OK/

          if File.exist? '/etc/default/grub'
            apply_grub '/etc/default/grub'
          elsif @args[:syslinux]
            apply_syslinux @args[:syslinux]
          elsif File.exist? '/boot/syslinux/syslinux.cfg'
            apply_syslinux '/boot/syslinux/syslinux.cfg'
          elsif @args[:bootctl]
            apply_bootctl @args[:bootctl]
          else
            puts
            puts "[-] No config file supported yet to applying #{@name}."
          end
        end

        # conf path can be something like:
        # /efi/loader/entries/gentoo.conf
        def apply_bootctl(conf)
          line = get_bootctl_line(conf)
          args = []
          line.split(' ').each { |a| args << a if a =~ /[a-z0-9=]+/ }
          args << @name
          args = args.uniq()
          args.delete('options')
          @final_line = 'options ' + args.join(' ')
          puts ' > line > ' + @final_line
          sed(/^options/, "#{@final_line}", conf)
        end

        def get_bootctl_line(conf)
          File.readlines(conf).each { |l| return l if l =~ /^options/ }
          'options'
        end

        def apply_syslinux(conf)
          line = get_syslinux_line(conf)
          args = []
          line.split(' ').each { |a| args << a if a =~ /[a-z0-9=]+/ }
          args << @name
          args = args.uniq()
          @final_line = 'APPEND ' + args.join(' ')
          puts ' > line > ' + @final_line
          sed(/\s+APPEND/, "    #{@final_line}", conf) # with 4 spaces
        end

        # apply_grub
        # Get all the current arguments from config file
        # And reinject them with new @name
        # Build the variable @final_line
        def apply_grub(conf)
          line = get_grub_line(conf)
          args = []

          line_split = line.split("GRUB_CMDLINE_LINUX_DEFAULT=\"")
          args_split = line_split[1].split(' ')
          args_split.each { |a| args << a.tr('"', '') if a =~ /[a-z0-9=]+/ }
          args << @name
          args = args.uniq()

          @final_line = "GRUB_CMDLINE_LINUX_DEFAULT=\"" + args.join(' ') + "\""
          puts ' > line > ' + @final_line
          write_to_grub(conf)
        end

        def write_to_grub(conf)
          sed(/^GRUB_CMDLINE_LINUX_DEFAULT/, @final_line, conf)
        end

        def get_grub_line(conf)
          File.readlines(conf).each { |l| return l if l =~ /^GRUB_CMDLINE_LINUX_DEFAULT/ }
          "GRUB_CMDLINE_LINUX_DEFAULT=\"\""
        end

        def get_syslinux_line(conf)
          File.readlines(conf).each { |l| return l if l =~ /\s+APPEND/ }
          'APPEND'
        end
      end

      class SlabNoMerge < CmdLine::LineInc
        def initialize(args)
          super
          @name = 'slab_nomerge'
        end
      end

      class SlubDebug < CmdLine::LineInc
        def initialize(args)
          super
          @name = 'slub_debug=ZF'
        end
      end

      class InitOnAlloc < CmdLine::LineInc
        def initialize(args)
          super
          @name = 'init_on_alloc=1'
        end
      end

      class InitOnFree < CmdLine::LineInc
        def initialize(args)
          super
          @name = 'init_on_free=1'
        end
      end

      class PageAllocShuffle < CmdLine::LineInc
        def initialize(args)
          super
          @name = 'page_alloc.shuffle=1'
          @tab = 3
        end
      end
    end
  end
end
