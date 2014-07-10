require 'singleton'

module Varspec
  module BuiltinMatcher
    class ArrayOf < Matcher
      attr_reader :matcher
      
      def initialize(matcher)
        @matcher = matcher
      end
      
      def invalid_variable?(val)
        if not val.is_a?(Array)
          return val.inspect
        else
          val.each_with_index do |x, i|
            if msg = matcher.invalid_variable?(x)
              return "invalid element (index = #{i}): #{msg}"
            end
          end
        end
        
        false
      end
      
      def to_s
        "[#{matcher}]"
      end
      
    end
    
    class HashOf < Matcher
      attr_reader :key_matcher, :value_matcher
    
      def initialize(key_matcher, value_matcher)
        @key_matcher = key_matcher
        @value_matcher = value_matcher
      end
      
      def invalid_variable?(val)
        if not val.is_a?(Hash)
          val.inspect
        else
          val.each_pair do |key, value|
            if msg = key_matcher.invalid_variable?(key)
              return "invalid key: #{msg}"
            else msg = value_matcher.invalid_variable?(value)
              return "invalid value (key = #{key.inspect}): #{msg}"
            end
          end
        end
        
        false
      end
      
      def to_s
        "{#{key_matcher} => #{value_matcher}}"
      end
    end
    
    class Booelean < Matcher
      include Singleton
      def invalid_variable? val
        if val == true || val == false
          false
        else
          val.inspect
        end
      end
      
      def self.invalid_variable?(val)
        instance.invalid_variable(val)
      end
      
      def to_s
        "Boolean"
      end
    end
    
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
    
    # Define module function corresponding each builtin matcher
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
