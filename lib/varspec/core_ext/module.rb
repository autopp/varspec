class Module
  def invalid_variable?(val)
    val.is_a?(self) ? false : val.inspect
  end
end
