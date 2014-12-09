module Varspec
  module BuiltinMatcher
    class HashOf < Matcher
      def initialize(key_matcher, value_matcher)
        @key_matcher = key_matcher
        @value_matcher = value_matcher
      end
      
      def invalid_variable?(val)
        if !val.is_a?(Hash)
          val.inspect
        else
          val.each_pair do |key, value|
            msg = @key_matcher.invalid_variable?(key)
            return "invalid key: #{msg}" if msg
            
            msg = @value_matcher.invalid_variable?(value)
            return "invalid value (key = #{key.inspect}): #{msg}" if msg
          end
        end
        
        false
      end
      
      def to_s
        "{#{@key_matcher} => #{@value_matcher}}"
      end
    end
  end
end
