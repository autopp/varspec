module Varspec
  class VariableEnv
    attr_reader :env
    
    def initialize(env)
      @env = env
    end
    
    def is(matcher, level = 1)
      env.each_pair do |name, value|
        if msg = matcher.invalid_variable?(value)
          if /^(.+?):(\d+):in/ =~ caller[level]
            file, line = $1, $2
          else
            file = line = ''
          end
          raise ValidationError.new(name, file, line, matcher.to_s, msg)
        end
      end
      
      true
    end
  end
end

