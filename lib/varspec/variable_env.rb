module Varspec
  class VariableEnv
    def initialize(instance, names, values)
      @instance = instance
      @names = names
      @values = values
    end
    
    def to(matcher, level = 0)
      @values.each_with_index do |v, i|
        msg = matcher.invalid_variable?(v)
        
        next unless msg
        
        # Extract callee
        if /^(.+?):(\d+):in/ =~ caller[level + 3]
          callee_file, callee_line = Regexp.last_match[1], Regexp.last_match[2]
        else
          callee_file = callee_line = ''
        end
        
        # Extract caller
        if /^(.+?):(\d+):in/ =~ caller[level + 4]
          caller_file, caller_line = Regexp.last_match[1], Regexp.last_match[2]
        else
          caller_file = caller_line = ''
        end
        
        fail ValidationError.new(@names[i], callee_file, callee_line, caller_file, caller_line, matcher.to_s, msg)
      end
      
      if @values.length == 1
        @values.first
      else
        @values
      end
    end
    
    alias_method :to_be, :to
    
    def of_instance_to(matcher)
      ret = self.to(matcher, 1)
      @names.each_with_index do |name, i|
        @instance.instance_variable_set("@#{name}", @values[i])
      end
      
      ret
    end
    
    alias_method :of_instance_to_be, :of_instance_to
  end
end
