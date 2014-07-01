module Varspec
  class VariableEnv
    attr_reader :env
    
    def initialize(env)
      @env = env
    end
    
    def is(matcher, level = 0)
      env.each_pair do |name, value|
        if msg = matcher.invalid_variable?(value)
          # Extract callee
          if /^(.+?):(\d+):in/ =~ caller[level+2]
            callee_file, callee_line = $1, $2
          else
            callee_file = callee_line = ''
          end
          
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
  end
end

