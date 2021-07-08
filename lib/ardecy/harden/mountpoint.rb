# frozen_string_literal: true

require 'display'
require 'tempfile'
require 'fileutils'

module Ardecy
  module Harden
    module Mountpoint
      def self.exec(args)
        ProcHidepid.new(args).x
        puts " ===> Mountpoint Corrected." if args[:fix]
      end

      class MountInc
        include Display

        def initialize(args)
          @res = 'FAIL'
          @args = args
          @tab = 2
        end

        def x
          scan
          fix
          systemd_case
        end

        def scan
          return unless mount_match('/proc/mounts')

          print " - Checking #{@name} contain " + @ensure.join(',') if @args[:audit]
          v = @val.split ' '
          @ensure.each do |e|
            v[3] += ",#{e}" unless v[3] =~ /#{e}/
          end

          @new = v.join(' ')
          @res = "OK" if @val == @new
          @tab ? result(@res, @tab) : result(@res) if @args[:audit]
        end

        def fix
          return unless @args[:fix] && @res =~ /OK/

          if mount_match('/etc/fstab')
            edit_fstab
          else
            File.write('/etc/fstab', "\n#{@new}\n", mode: 'a')
          end

          puts "old -> " + @val
          puts "new -> " + @new
          puts
        end

        def mount_match(file)
          File.readlines(file).each do |l|
            if l =~ /^#{@name}/
              @val = l
              return true
            end
          end
          false
        end

        def edit_fstab
          tmp = Tempfile.new('fstab')
          File.open('/etc/fstab').each do |l|
            if l.match(/^#{@name}/)
              File.write(tmp, "#{@new}\n", mode: 'a')
            else
              File.write(tmp, l, mode: 'a')
            end
          end
          FileUtils.mv tmp, '/etc/fstab'
          File.chmod(0644, '/etc/fstab')
        end

        def systemd_case
        end
      end

      class ProcHidepid < Mountpoint::MountInc
        def initialize(args)
          super
          @name = 'proc'
          @ensure = [ 'hidepid=2', 'gid=proc' ]
        end

        def systemd_case
          return unless @args[:fix]

          if File.exist? '/etc/systemd/logind.conf'
            create_content '/etc/systemd/logind.conf.d'
          end
        end

        def create_content(in_dir)
          content = [
            '[Service]',
            'SupplementaryGroups=proc',
            ''
          ]
          Dir.mkdir in_dir, 0700 unless Dir.exists? in_dir
          File.write("#{in_dir}/hidepid.conf", content.join("\n"), mode: 'w')
          puts " > Creating file #{in_dir}/hidepid.conf"
        end
      end
    end
  end
end
