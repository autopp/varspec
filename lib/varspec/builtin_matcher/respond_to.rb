module Varspec
  module BuiltinMatcher
    class RespondTo < Matcher
      def initialize(*method_names)
        if method_names.any? { |name| !name.is_a?(Symbol) && !name.is_a?(String) }
          fail TypeError, 'require Symbol or String'
        end
        
        @method_names = method_names
      end
      
      def invalid_variable?(val)
        @method_names.each do |name|
          return val.inspect unless val.respond_to(name)
        end
        
        false
      end
      
      def to_s
        "respond_to #{@method_names.join}"
      end
    end
  end
end
