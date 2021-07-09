# frozen_string_literal: true

require 'tempfile'
require 'fileutils'

# Nito for Nix Tools
module NiTo

  # Like sed from Unix
  def sed(regex, replacement, file)
    tmp = Tempfile.new('tmp_sed')
    File.open(@file).each do |l|
      if l.match @regex
        File.write(tmp, "#{replacement}\n", mode: 'a')
      else
        File.write(tmp, l, mode: 'a')
      end
    end
    FileUtils.mv tmp, @file
    File.chmod 0644, @file
  end
end
