# frozen_string_literal: true

require 'display'
require 'nito'

module Ardecy
  class FileEdit
    include Display
    include NiTo

    def initialize(args)
      @args = args
      @res = 'FAIL'
    end

    def x
      unless File.exists? @file
        @res = 'NO FOUND'
        show_result
        return
      end

      scan
      fix
    end

    def show_result
      return unless @args[:audit]

      kernel_show(@file, @content)
      @tab ? result(@res, @tab) : result(@res)
    end

    def scan
      line = search_content

      @res = 'OK' if line =~ /^#{@content}/
      show_result
    end

    def fix
      return if !@args[:fix] || @res =~ /OK/

      edit
    end

    def edit
      line = search_content
      if line
        sed(/^#{@edit}/, @content, @file)
        print " ===> Edit #{@edit} by #{@content} to #{@file} \n\n"
      else
        File.write(@file, "#{@content}\n", mode: 'a', preserve: true)
        print " ===> Added #{@content} to #{@file}\n\n"
      end
    end

    def search_content
      content = nil
      if File.readable? @file
        File.readlines(@file).each { |l| content = l if l =~ /^#{@edit}/ }
      else
        puts "File #{@file} is protected."
      end
      return content
    end
  end

  # FileNew
  # This class work only if the variable @only_if is true (filename exist)
  # If true, can create a directory @need_dir (String, absolute path)
  # create a file @file (String, absolute path)
  # and add content @content (Array)
  class FileNew < FileEdit
    def initialize(args)
      super
    end

    def x
      return unless File.exists? @only_if

      search_dir
      search_file
      scan
      fix
    end

    def fix
      return unless @args[:fix]

      @content << ""
      File.write(@file, @content.join("\n"), mode: 'w')
      puts " ===> Writing file #{@file}"
    end

    def scan
      line = search_line
      @res = 'PROTECTED' if @need_dir && File.readable?(@need_dir)
      @res = 'OK' if line
      show_result
    end

    def search_file
      return if File.exist? @file

      @res = 'NO FOUND'
    end

    def show_result
      return unless @args[:audit]

      kernel_show(@file, @content.last)
      @tab ? result(@res, @tab) : result(@res)
    end

    def search_line
      content = nil
      if File.exists? @file
        File.readlines(@file).each { |l| content = l if l =~ /#{@content.last}/ }
      end
      return content
    end

    def search_dir
      return unless @need_dir

      unless Dir.exists? @need_dir
        @res = 'NO FOUND'
        return unless @args[:fix]

        mkdir @need_dir, 0644 unless Dir.exist? @need_dir
      end
    end
  end
end
