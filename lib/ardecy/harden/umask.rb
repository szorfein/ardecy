# frozen_string_literal: true

module Ardecy
  module Harden
    module Umask
      def self.exec(args)
        Umask::Profile.new(args).x
        Umask::LoginDefs.new(args).x
        puts " ===> Corrected" if args[:fix]
      end

      class Profile < FileEdit
        def initialize(args)
          super
          @file = '/etc/profile'
          @content = 'umask 027'
          @edit = 'umask'
          @tab = 3
        end
      end

      class LoginDefs < FileEdit
        def initialize(args)
          super
          @file = '/etc/login.defs'
          @content = 'UMASK 027'
          @edit = 'UMASK'
          @tab = 3
        end
      end
    end
  end
end
