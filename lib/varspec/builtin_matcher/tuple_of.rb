module Varspec
  module BuiltinMatcher
    class TupleOf < Matcher
      def initialize(*matcher_list)
        @matcher_list = matcher_list
      end
      
      def invalid_variable?(val)
        return val.inspect unless val.is_a?(Array) && val.length == @matcher_list.length
        
        val.each_with_index do |v, i|
          msg = @matcher_list[i].invalid_variable?(v)
          return msg if msg
        end
        
        false
      end
      
      def to_s
        "(#{@matcher_list.join(', ')})"
      end
    end
  end
end
