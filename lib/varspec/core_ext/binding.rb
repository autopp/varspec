# 
#
# @author autopp <autopp.inc@gmail.com>
#
class Binding
  LOCAL_VARIABLE_PATTERN = /\A[_a-z][_a-zA-Z0-9]*\z/
  
  def [](*names)
    values = names.map do |name|
      raise TypeError, "require Symbol, but got #{name.inspect}" if not name.is_a?(Symbol)
      raise ArgumentError, "require valid local variable name, but got '#{name}'" if not name =~ LOCAL_VARIABLE_PATTERN
      self.local_variable_get(name)
    end
    
    Varspec::VariableEnv.new(Kernel.eval('self', self), names, values)
  end
end
