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
          return unless @args[:fix] && !@res =~ /OK/

          if File.exist? '/etc/default/grub'
            apply_grub '/etc/default/grub'
          else
            puts
            puts "[-] No config file supported yet to applying #{@name}."
          end
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

          @final_line = "GRUB_CMDLINE_LINUX_DEFAULT=\"" + args.join(' ') + "\""
          puts " > line > " + @final_line
        end

        def write_to_grub
          sed(/^GRUB_CMDLINE_LINUX_DEFAULT/, @final_line, '/etc/default/grub')
        end

        def get_grub_line(conf)
          File.readlines(conf).each { |l| return l if l =~ /^GRUB_CMDLINE_LINUX_DEFAULT/ }
          "GRUB_CMDLINE_LINUX_DEFAULT=\"\""
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
