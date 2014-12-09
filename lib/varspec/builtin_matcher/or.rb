module Varspec
  module BuiltinMatcher
    class Or < Matcher
      attr_reader :matchers
      
      def initialize(*matchers)
        if matchers.length == 0
          fail ArgumentError, 'require 1 more than matcher'
        end
        @matchers = matchers
      end
      
      def invalid_variable?(val)
        @matchers.each do |matcher|
          return false unless matcher.invalid_variable?(val)
        end
        
        val.inspect
      end
      
      def to_s
        if @matchers.length == 1
          @matchers[0].inspect
        else
          @matchers[0, @matchers.length - 1].map(&:inspect).join(', ') + " or #{@matchers[-1]}"
        end
      end
    end
  end
end
