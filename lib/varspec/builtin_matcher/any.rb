module Varspec
  module BuiltinMatcher
    class Any < Matcher
      def initialize
      end
      
      def invalid_variable?(val)
        false
      end
      
      def to_s
        'anything'
      end
    end
  end
end
