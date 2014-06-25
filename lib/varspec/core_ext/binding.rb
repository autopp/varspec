class Binding
  LOCAL_VARIABLE_PATTERN = /\A[_a-z][_a-zA-Z0-9]*\z/
  
  def [](name)
    raise TypeError, "require Symbol, but got #{name.inspect}" if not name.is_a?(Symbol)
    raise ArgumentError, "require valid local variable name, but got '#{name}'" if not name =~ LOCAL_VARIABLE_PATTERN
    eval("#{name}", self)
    Varspec::Variable.new(name, value)
  end
end
