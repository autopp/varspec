require 'singleton'

module Varspec
  module BuiltinMatcher
    class Boolean < Matcher
      include Singleton
      def initialize(*args)
      end
      
      def invalid_variable? val
        if val == true || val == false
          false
        else
          val.inspect
        end
      end
      
      def self.invalid_variable?(val)
        instance.invalid_variable?(val)
      end
      
      def to_s
        "Boolean"
      end
    end
  end
end
