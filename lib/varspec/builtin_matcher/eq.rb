module Varspec
  module BuiltinMatcher
    class Eq < Matcher
      def initialize(target)
        @target = target
      end
      
      def invalid_variable?(val)
        if val == @target
          false
        else
          "#{val}"
        end
      end
      
      def to_s
        "equal to #{@target}"
      end
    end
  end
end
