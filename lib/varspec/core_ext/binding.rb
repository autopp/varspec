# 
#
# @author autopp <autopp.inc@gmail.com>
#
class Binding
  LOCAL_VARIABLE_PATTERN = /\A[_a-z][_a-zA-Z0-9]*\z/
  
  def [](*names)
    values = names.map do |name|
      raise TypeError, "require Symbol or String, but got #{name.inspect}" if not (name.is_a?(Symbol) || name.is_a?(String))
      
      self.eval("#{name}")
    end
    
    Varspec::VariableEnv.new(Kernel.eval('self', self), names, values)
  end
end
