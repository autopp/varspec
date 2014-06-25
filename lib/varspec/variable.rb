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
  end
end
