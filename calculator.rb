require_relative "validation_errors"

class Calculator

  attr_accessor :equation, :stack, :result, :equation_status, :parenthases_stack

  def initialize equation
    @equation = equation
    @stack = []
    @result = 0
    @equation_status = true
    @parenthases_stack =[]

    run_calculator
  end

  def run_calculator
    process_stack
    # evaluate_equation
    # evaluate_result unless self.stack.empty?
    # print_result
  end

  def print_result
    if equation_is_valid?
      puts self.result
    else
      raise ValidationErrors.new
    end
  end

  def evaluate_equation
    terms = stack

    while terms.length > 0
      term = terms.pop
      case
      when is_numeric?(term) || ['*', '+', '/', '-'].include?(term)
        stack << term
      when term == '('
        if self.parenthases_stack.empty?
          msg = "Parenthesis error"
          raise ValidationErrors.new(msg)
        else
          parenthases_stack.pop
          self.evaluate_result
        end
      when term == ')'
        parenthases_stack << term
      else
      end
    end
  end

  def equation_is_valid?
     self.equation_status
  end

  def evaluate_result
    current_equation = self.stack.map{ |term| term.to_s }.join(' ')
    evaluation = eval(current_equation)
    if is_numeric?(evaluation) && self.parenthasis_matched?
      self.result += evaluation
    else
      if !self.parenthasis_matched?
        msg = "The parenthasis do not match on submitted equation"
      else
        msg = "Equation Not Valid: #{current_equation}"
        raise ValidationErrors.new(msg)
      end
    end
    reset_stack
  end

  private

  def reset_stack
    self.stack = []
  end

  def parenthasis_matched?
    self.parenthases_stack.empty?
  end

  def process_stack
    self.stack = self.equation.split(" ")
  end

  def is_numeric? string
    true if Float(string) rescue false
  end

end
