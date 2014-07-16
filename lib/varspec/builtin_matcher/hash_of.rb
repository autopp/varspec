module Varspec
  module BuiltinMatcher
    class HashOf < Matcher
      def initialize(key_matcher, value_matcher)
        @key_matcher = key_matcher
        @value_matcher = value_matcher
      end
      
      def invalid_variable?(val)
        if not val.is_a?(Hash)
          val.inspect
        else
          val.each_pair do |key, value|
            if msg = @key_matcher.invalid_variable?(key)
              return "invalid key: #{msg}"
            else msg = @value_matcher.invalid_variable?(value)
              return "invalid value (key = #{key.inspect}): #{msg}"
            end
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
