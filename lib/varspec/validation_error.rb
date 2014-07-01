module Varspec
  class ValidationError < StandardError
    attr_reader :variable, :callee_file, :callee_line, :caller_file, :caller_line, :expected, :actual, :msg
    def initialize(variable, callee_file, callee_line, caller_file, caller_line, expected, actual)
      @variable = variable
      
      @callee_file = callee_file
      @callee_line = callee_line
      
      @caller_file = caller_file
      @caller_line = caller_line
      
      @expected = expected
      @actual = actual
      @msg = <<-EOS
variable `#{variable}' is violated! (at #{callee_file}:#{callee_line})
  Expected: #{expected}
  Actual: #{actual}
  Caller: #{caller_file}:#{caller_line}
      EOS
      super(@msg)
    end
    
    def callee_loc
      [callee_file, callee_line]
    end
    
    alias loc callee_loc
    
    def caller_loc
      [caller_file, caller_line]
    end
    
    def to_s
      msg
    end
  end
end
