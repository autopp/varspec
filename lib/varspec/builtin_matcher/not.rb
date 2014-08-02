module Varspec
  module BuiltinMatcher
    class Not
      def initialize(matcher)
        @matcher = matcher
      end
      
      def invalid_variable?(val)
        if !@matcher.invalid_variable?(val)
          val.inspect
        else
          false
        end
      end
      
      def to_s
        "not #{@matcher}"
      end
    end
  end
end
