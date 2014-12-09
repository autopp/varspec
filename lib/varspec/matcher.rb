module Varspec
  class Matcher
    def initialize(*args)
      fail StandardError, "#{self.inspect} is abstract class"
    end
    
    def self.[](*matchers)
      self.new(*matchers)
    end
  end
end
