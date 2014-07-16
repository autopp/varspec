module Varspec
  module BuiltinMatcher
    class ArrayOf < Matcher
      def initialize(matcher)
        @matcher = matcher
      end
      
      def invalid_variable?(val)
        if not val.is_a?(Array)
          return val.inspect
        else
          val.each_with_index do |x, i|
            if msg = @matcher.invalid_variable?(x)
              return "at index #{i}: #{msg}"
            end
          end
        end
        
        false
      end
      
      def to_s
        "[#{@matcher}]"
      end
    end
  end
end
