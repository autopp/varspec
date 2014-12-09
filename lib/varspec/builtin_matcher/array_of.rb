module Varspec
  module BuiltinMatcher
    class ArrayOf < Matcher
      def initialize(matcher)
        @matcher = matcher
      end
      
      def invalid_variable?(val)
        if !val.is_a?(Array)
          return val.inspect
        else
          case @length_cond
          when :<
            return val.inspect if val.length >= @length
          when :<=
            return val.inspect if val.length > @length
          when :>
            return val.inspect if val.length <= @length
          when :>=
            return val.inspect if val.length < @length
          when :eq
            return val.inspect if val.length != @length
          when :not_eq
            return val.inspect if val.length == @length
          end
          
          val.each_with_index do |x, i|
            msg = @matcher.invalid_variable?(x)
            return "at index #{i}: #{msg}" if msg
          end
        end
        
        false
      end
      
      def to_s
        if @length_cond
          "[#{@matcher}] (length #{@length_cond} #{@length})"
        else
          "[#{@matcher}]"
        end
      end
      
      def <(other)
        @length_cond = :<
        @length = length
        self
      end
      
      def <=(other)
        @length_cond = :<=
        @length = length
        self
      end
      
      def >(other)
        @length_cond = :>
        @length = length
        self
      end
      
      def >=(other)
        @length_cond = :>=
        @length = length
        self
      end
      
      def eq(other)
        @length_cond = :eq
        @length = length
        self
      end
      
      def not_eq(other)
        @length_cond = :not_eq
        @length = length
        self
      end
    end
  end
end
