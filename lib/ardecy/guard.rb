# frozen_string_literal: true

module Ardecy
  class BadPerm < StandardError
  end

  module Guard
    def self.perm
      uid = Process.uid
      raise BadPerm, 'Please, run this program as a root.' unless uid === 0
    rescue BadPerm => e
      warn "\n#{e.class} > #{e}"
      exit 1
    end
  end
end
