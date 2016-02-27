class ValidationErrors < StandardError
  attr_reader :thing

  def initialize(msg="Equation is not valid")
    super
  end
end
