# frozen_string_literal: true

require 'tempfile'
require 'fileutils'

# Nito for Nix Tools
module NiTo

  # sed
  # Like sed from Unix
  # e.g > sed(/^GRUB_CMDLINE/, '', '/etc/default/grub)
  def sed(regex, replacement, file)
    tmp = Tempfile.new('tmp_sed')
    File.open(file).each do |l|
      if l.match regex
        File.write(tmp, "#{replacement}\n", mode: 'a')
      else
        File.write(tmp, l, mode: 'a')
      end
    end
    mv tmp, file
  end

  # mv (move file || directory)
  # e.g > mv /home/user/lab, /tmp/lab, 0750
  def mv(src, dest, perm = 0644)
    FileUtils.mv src, dest
    File.chmod perm, dest
  end

  # mkdir
  def mkdir(dir, perm = 0644)
    FileUtils.mkdir_p dir
    File.chmod perm, dir
  end
end
