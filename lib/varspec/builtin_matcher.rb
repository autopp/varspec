module Varspec
  module BuiltinMatcher
    class Any < Matcher
      def initialize
      end
      
      def invalid_variable?(val)
        false
      end
      
      def to_s
        "anything"
      end
    end
    
    class None < Matcher
      def initialize
      end
      
      def invalid_variable?(val)
        val.inspect
      end
      
      def to_s
        "nothing"
      end
    end
    
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

# load each builtin matcher
require 'varspec/builtin_matcher/array_of'
require 'varspec/builtin_matcher/hash_of'
require 'varspec/builtin_matcher/boolean'
require 'varspec/builtin_matcher/eq'
require 'varspec/builtin_matcher/not'
require 'varspec/builtin_matcher/and'
require 'varspec/builtin_matcher/or'
require 'varspec/builtin_matcher/maybe'
require 'varspec/builtin_matcher/truthy'
require 'varspec/builtin_matcher/falsey'

# Define module function corresponding each builtin matcher
module Varspec
  module BuiltinMatcher
    self.constants(false).select{ |c| self.const_get(c, false) < Matcher }.each do |c|
      eval <<-EOS
        def #{c}(*args)
          #{c}[*args]
        end
        
        module_function #{c.inspect}
      EOS
    end
  end
end
