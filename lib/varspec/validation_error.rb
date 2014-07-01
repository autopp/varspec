module Varspec
  class ValidationError < StandardError
    attr_reader :variable, :file, :line, :expected, :actual, :msg
    def initialize(variable, file, line, expected, actual)
      @variable = variable
      @file = file
      @line = line
      @expected = expected
      @actual = actual
      @msg = <<-EOS
variable `#{variable}' is violated! (at #{file}:#{line})
  Expected: #{expected}
  Actual: #{actual}
      EOS
      super(@msg)
    end
    
    def to_s
      msg
    end
  end
end
