# This core extention aliases <tt>#binding</tt> to <tt>#variable</tt> 
#
# @author autopp <autopp.inc@gmail.com>
#
module Kernel
  #
  # @return Binding
  # 
  alias :variable :binding
  
  if defined? invalid_variable?
    warn 'Kernel.#invalid_variable is redefined'
  end
  
  def invalid_variable?(val)
    if self == val
      false
    else
      val.inspect
    end
  end
end
