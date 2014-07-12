module Varspec
  module BuiltinMatcher
    class Eq < Matcher
      attr_reader :target
      
      def initialize(target)
        @target = target
      end
      
      def invalid_variable?(val)
        if val == target
          false
        else
          "#{val}"
        end
      end
      
      def to_s
        "equal to #{target}"
      end
    end
    
    class Or < Matcher
      attr_reader :matchers
      
      def initialize(*matchers)
        if matchers.length == 0
          raise ArgumentError, "require 1 more than matcher"
        end
        @matchers = matchers
      end
      
      def invalid_variable?(val)
        matchers.each do |matcher|
          if not matcher.invalid_variable?(val)
            return false
          end
        end
        
        val.inspect
      end
      
      def to_s
        if matchers.length == 1
          matchers[0].inspect
        else
          matchers[0, matchers.length-1].map(&:inspect).join(', ') + " or #{matchers[-1]}"
        end
      end
    end
    
    class Maybe < Or
      def initialize(matcher)
        @matcher = matcher
        super(matcher, nil)
      end
      
      def to_s
        "may be #{@matcher}"
      end
    end
    
    class All < Matcher
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
    
    class Not
      attr_reader :matcher
      
      def initialize(matcher)
        @matcher = matcher
      end
      
      def invalid_variable?(val)
        if !matcher.invalid_variable?(val)
          val.inspect
        else
          false
        end
      end
      
      def to_s
        "not #{matcher}"
      end
    end
    
    class Truthy < Matcher
      def initialize
      end
      
      def invalid_variable?(val)
        if val
          false
        else 
          val.inspect
        end
      end
      
      def to_s        
        "truthy value"
      end
    end
    
    class Falsey < Matcher
      def initialize
      end
      
      def invalid_variable?(val)
        if val
          val.inspect
        else
          false
        end
      end
      
      def to_s
        "falsey value"
      end
    end
    
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
