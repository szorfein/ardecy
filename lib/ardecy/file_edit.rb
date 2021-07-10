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
end
