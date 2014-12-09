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
          case @length_cond
          when :<
            if val.length >= @length
              return val.inspect
            end
          when :<=
            if val.length > @length
              return val.inspect
            end
          when :>
            if val.length <= @length
              return val.inspect
            end
          when :>=
            if val.length < @length
              return val.inspect
            end
          when :eq
            if val.length != @length
              return val.inspect
            end
          when :not_eq
            if val.length == @length
              return val.inspect
            end
          end
          
          val.each_with_index do |x, i|
            if msg = @matcher.invalid_variable?(x)
              return "at index #{i}: #{msg}"
            end
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
      
      def < length
        @length_cond = :<
        @length = length
        self
      end
      
      def <= length
        @length_cond = :<=
        @length = length
        self
      end
      
      def > length
        @length_cond = :>
        @length = length
        self
      end
      
      def >= length
        @length_cond = :>=
        @length = length
        self
      end
      
      def eq length
        @length_cond = :eq
        @length = length
        self
      end
      
      def not_eq length
        @length_cond = :not_eq
        @length = length
        self
      end
      
      
    end
  end
end
