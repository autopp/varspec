# This core extention aliases <tt>#binding</tt> to <tt>#variable</tt> 
#
# @author autopp <autopp.inc@gmail.com>
#
module Kernel
  #
  # @return Binding
  # 
  alias_method :expect_variable, :binding
  alias_method :expect_var, :expect_variable
    
  warn 'Kernel.#invalid_variable is redefined' if defined? invalid_variable?
  
  
  def invalid_variable?(val)
    if self == val
      false
    else
      val.inspect
    end
  end
end
