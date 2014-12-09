module Varspec
  module BuiltinMatcher
    class Falsey < Matcher
      def initialize
      end
      
      def invalid_variable?(val)
        if val
          val.inspect
        else
          false
        end
      end
      
      def to_s
        'falsey value'
      end
    end
  end
end
