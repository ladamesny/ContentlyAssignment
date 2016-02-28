require_relative "validation_errors"

class Calculator

  attr_accessor :equation, :stack, :result, :equation_status, :closing_parenthases_stack

  def initialize equation
    @equation = equation
    @stack = []
    @result = 0
    @equation_status = true
    @closing_parenthases_stack =[]
  end

  def run_calculator
    process_equation

    validate_equation

    begin
      evaluate_result
    rescue SyntaxError
    end
  end

  def evaluate_result
    self.result = eval(self.equation)
  end

  def validate_equation
    terms = self.stack
    count = terms.size
    while count > 0
      term = terms.pop
      count = terms.size
      case
      when term == '('
        if self.closing_parenthases_stack.empty?
          self.equation_status = false
          count = 0
        else
          self.closing_parenthases_stack.pop
        end
      when term == ')'
        self.closing_parenthases_stack << term
      end
    end
  end


  def equation_is_valid?
    parenthasis_matched? && self.equation_status
  end

  def process_equation
    self.stack = self.equation.split(" ")
  end

  def answer
    self.result
  end

  private

  def parenthasis_matched?
    self.closing_parenthases_stack.empty?
  end


  def is_numeric? string
    true if Float(string) rescue false
  end

end
