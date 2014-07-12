module Varspec
  module BuiltinMatcher
    class RespondTo < Matcher
      attr_reader :method_names
      def initialize(*method_names)
        if method_names.any?{ |name| !name.is_a?(Symbol) && !name.is_a?(String) }
          raise TypeError, "require Symbol or String"
        end
        
        @method_names = method_names
      end
      
      def invalid_variable?(val)
        method_names.each do |name|
          if !val.respond_to(name)
            return val.inspect
          end
        end
        
        false
      end
      
      def to_s
        "respond_to #{method_names.join}"
      end
    end
  end
end