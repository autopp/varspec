module Varspec
  module BuiltinMatcher
    class Truthy < Matcher
      def initialize
      end
      
      def invalid_variable?(val)
        if val
          false
        else 
          val.inspect
        end
      end
      
      def to_s        
        'truthy value'
      end
    end
  end
end
