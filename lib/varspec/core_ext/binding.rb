# 
#
# @author autopp <autopp.inc@gmail.com>
#
class Binding
  LOCAL_VARIABLE_PATTERN = /\A[_a-z][_a-zA-Z0-9]*\z/
  
  def [](*names)
    env = names.each_with_object({}) do |name, env|
      raise TypeError, "require Symbol, but got #{name.inspect}" if not name.is_a?(Symbol)
      raise ArgumentError, "require valid local variable name, but got '#{name}'" if not name =~ LOCAL_VARIABLE_PATTERN
      env[name] = Kernel.eval("#{name}", self)
    end
    Varspec::VariableEnv.new(env)
  end
  
end
