# frozen_string_literal: true

require 'display'

module Ardecy
  module Harden
    module Sysctl
      KERNEL = []
      NETWORK = []

      class SysKern
        include Display

        def scan
          kernel_show(@line, @exp) if @args[:audit]
          if File.exist? @file
            if File.readable? @file
              value = File.read(@file).chomp
              @res = value.to_s =~ /#{@exp}/ ? 'OK' : 'FAIL'
            else
              @res = 'PROTECTED'
            end
          else
            @res = 'NO FOUND'
          end
          if @tab
            kernel_res(@res, @tab) if @args[:audit]
          elsif @args[:audit]
            kernel_res(@res)
          end
        end

        def fix
          return unless File.exist? @file

          KERNEL << "#{@line} = #{@exp}"
        end

        def repair
          return unless @args[:fix]

          Ardecy::Guard.perm
          if @res != 'OK' && @res != 'PROTECTED'
            if File.exist? @file
              File.write(@file, @exp, mode: 'w', preserve: true)
            end
          end
        end

        def x
          scan
          fix
          repair
        end
      end

      class SysNet < SysKern
        def fix
          return unless File.exist? @file

          NETWORK << "#{@line} = #{@exp}"
        end
      end
    end
  end
end

require_relative 'sysctl/kernel'
require_relative 'sysctl/network'
