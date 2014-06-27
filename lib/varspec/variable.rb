module Varspec
  class Variable
    # @!attribute [r] name
    #   @return [Symbol] name of variable
    attr_reader :name
    
    # @!attribute [r] value
    #   @return [Object] value of variable
    attr_reader :value
    
    # 
    #
    # @param [Symbol] name name of variable
    # @param [Object] value value of variable
    # 
    def initialize(name, value)
      @name = name
      @value = value
    end
    
    def is_kind_of(cls)
      if !value.is_a?(cls)
        if /^(.+?):(\d+)(?::in `.*')?/ =~ caller[1]
          file, line = $1, $2
        else
          file = line = ''
        end
        
        msg = <<-EOS
varibale `#{name}' at #{file}:#{line}
  Expected: #{cls}
  Actual: #{value}
        EOS
        
        raise ValidationError, msg
      end
      
      value
    end
    
    def is_array_of(cls)
      if not value.is_a? Array
        if /^(.+?):(\d+)(?::in `.*')?/ =~ caller[1]
          file, line = $1, $2
        else
          file = line = ''
        end
        
        msg = <<-EOS
varibale `#{name}' at #{file}:#{line}
  Expected: Array of #{cls}
  Actual: #{value.inspect}
        EOS
        raise ValidationError, msg
      end
      
      if value.any?{ |x| !x.is_a?(cls) }
        if /^(.+?):(\d+)(?::in `.*')?/ =~ caller[1]
          file, line = $1, $2
        else
          file = line = ''
        end
        msg = <<-EOS
variable `#{name}' at #{file}:#{line}
  Expected: Array of #{cls}
  Actual: #{value.inspect}
        EOS
        raise ValidationError, msg
      end
      
      value
    end
    alias is_ary_of is_array_of
    alias is_list_of is_array_of
  end
end
