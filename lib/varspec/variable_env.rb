module Varspec
  class VariableEnv
    def initialize(instance, names, values)
      @instance = instance
      @names = names
      @values = values
    end
=begin
    def is(matcher, level = 0)
      env.each_pair do |name, value|
        if msg = matcher.invalid_variable?(value)
          # Extract callee
          if /^(.+?):(\d+):in/ =~ caller[level+2]
            callee_file, callee_line = $1, $2
          else
            callee_file = callee_line = ''
          end
          
          # Extract caller
          if /^(.+?):(\d+):in/ =~ caller[level+3]
            caller_file, caller_line = $1, $2
          else
            caller_file = caller_line = ''
          end
          
          raise ValidationError.new(name, callee_file, callee_line, caller_file, caller_line, matcher.to_s, msg)
        end
      end
      
      true
    end
=end
    def to(matcher, level = 0)
      i = 0
      
      @values.each_with_index do |v, i|
        if msg = matcher.invalid_variable?(v)
          # Extract callee
          if /^(.+?):(\d+):in/ =~ caller[level+2]
            callee_file, callee_line = $1, $2
          else
            callee_file = callee_line = ''
          end
          
          # Extract caller
          if /^(.+?):(\d+):in/ =~ caller[level+3]
            caller_file, caller_line = $1, $2
          else
            caller_file = caller_line = ''
          end
          
          raise ValidationError.new(@names[i], callee_file, callee_line, caller_file, caller_line, matcher.to_s, msg)
        end
      end
      
      if @values.length == 1
        @values.first
      else
        @values
      end
    end
    
    alias to_be to
    
    def of_instance_to(matcher)
      ret = self.to(matcher, 1)
      @names.each_with_index do |name, i|
        @instance.instance_variable_set("@#{name}", @values[i])
      end
      
      ret
    end
    
    alias of_instance_to_be of_instance_to
  end
end
