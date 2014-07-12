module Varspec
  module BuiltinMatcher
    class None < Matcher
      def initialize
      end
      
      def invalid_variable?(val)
        val.inspect
      end
      
      def to_s
        "nothing"
      end
    end
  end
end