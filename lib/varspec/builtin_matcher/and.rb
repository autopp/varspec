module Varspec
  module BuiltinMatcher
    class And < Matcher
      attr_reader :matchers
      
      def initialize(*matchers)
        if matchers.length == 0
          raise ArgumentError, "require 1 more than matcher"
        end
        @matchers = matchers
      end
      
      def invalid_variable?(val)
        matchers.each do |matcher|
          if msg = matcher.invalid_variable?(val)
            return val.inspect
          end
        end
        
        false
      end
      
      def to_s
        if matchers.length == 1
          matchers[0].inspect
        else
          matchers[0, matchers.length-1].map(&:inspect).join(', ') + " and #{matchers[-1]}"
        end
      end
    end
  end
end
