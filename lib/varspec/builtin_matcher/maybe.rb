module Varspec
  module BuiltinMatcher
    class Maybe < Or
      def initialize(matcher)
        @matcher = matcher
        super(matcher, nil)
      end
      
      def to_s
        "may be #{@matcher}"
      end
    end
  end
end
