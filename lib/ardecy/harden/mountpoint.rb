# frozen_string_literal: true

require 'display'
require 'nito'

module Ardecy
  module Harden
    module Mountpoint
      def self.exec(args)
        ProcHidepid.new(args).x
        puts " ===> Mountpoint Corrected." if args[:fix]
      end

      class MountInc
        include Display
        include NiTo

        def initialize(args)
          @res = 'FAIL'
          @args = args
          @tab = 2
        end

        def x
          scan
          add_group
          build_args
          fix
          systemd_case
        end

        def add_group
          return unless @args[:fix] && @group

          has_group = group_search
          unless has_group
            if File.exists? '/usr/sbin/groupadd'
              puts " => Group #{@group} added." if system("/usr/sbin/groupadd #{@group}")
            elsif File.exists? '/usr/bin/groupadd'
              puts " => Group #{@group} added." if system("/usr/bin/groupadd #{@group}")
            else
              puts '[-] Can\'t find command groupadd'
            end
          end
        end

        def group_search
          if File.readable? '/etc/group'
            etc_group = File.readlines('/etc/group')
            etc_group.each { |l| return true if l =~ /#{@group}/ }
          else
            puts " [-] /etc/group is not readable"
          end
          false
        end

        def scan
          return unless mount_match('/proc/mounts')

          print "  - Checking #{@name} contain " + @ensure.join(',') if @args[:audit]
          res_a = []
          @ensure.each do |v|
            o = v.split('=')
            res_a << true if @val =~ /#{o[0]}=[a-z0-9]+/
          end
          @res = 'OK' if res_a.length == @ensure.length

          @tab ? result(@res, @tab) : result(@res) if @args[:audit]
        end

        def build_args
          return unless @args[:fix]
          return if @res =~ /OK/

          v = @val.split ' '
          @ensure.each do |e|
            o = e.split('=')
            v[3] += ",#{e}" unless v[3] =~ /#{o[0]}=[a-z0-9]+/
          end
          @new = v.join(' ')
        end

        def fix
          return unless @args[:fix]
          return if @res =~ /OK/

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
          sed(/^#{@name}/, @new, '/etc/fstab')
        end

        def systemd_case
        end
      end

      class ProcHidepid < Mountpoint::MountInc
        def initialize(args)
          super
          @name = 'proc'
          @ensure = [ 'hidepid=2', 'gid=proc' ]
          @group = 'proc'
        end

        # man logind.conf check under:
        # > /etc/systemd/logind.conf.d/*.conf
        # > /run/systemd/logind.conf.d/*.conf
        # > /usr/lib/systemd/logind.conf.d/*.conf
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
