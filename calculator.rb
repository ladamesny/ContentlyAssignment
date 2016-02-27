require_relative "validation_errors"

class Calculator

  attr_accessor :equation, :stack, :result, :equation_status, :parenthases_stack, :current_stack

  def initialize equation
    @equation = equation
    @stack = []
    @current_stack =[]
    @result = 0
    @equation_status = true
    @parenthases_stack =[]
  end

  def run_calculator
    process_stack
    evaluate_equation
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
    terms = self.stack
    count = terms.length
    while count > 0
      term = terms.pop
      count = count - 1
      case
      when is_numeric?(term) || ['*', '+', '/', '-'].include?(term)
        self.current_stack << term
      when term == '('
        if self.parenthases_stack.empty?
          msg = "Parenthesis error"
          raise ValidationErrors.new(msg)
        else
          self.parenthases_stack.pop
          evaluate_result
        end
      when term == ')'
        self.parenthases_stack << term
      end
    end
  end

  def equation_is_valid?
    parenthasis_matched? && self.stack.empty?
  end

  def evaluate_result
    current_equation = self.current_stack.map{ |term| term.to_s }.join(' ')
    evaluation = eval(current_equation)
    if ( is_numeric?(evaluation) == true ) && ( parenthasis_matched? == true )
      self.result += evaluation
    else
      if !parenthasis_matched?
        msg = "The parenthasis do not match on submitted equation"
      else
        msg = "Equation Not Valid: #{current_equation}"
      end
      raise ValidationErrors.new(msg)
    end
    reset_stack
  end

  def process_stack
    self.stack = self.equation.split(" ")
  end

  private

  def reset_stack
    self.stack = []
  end

  def parenthasis_matched?
    self.parenthases_stack.empty?
  end


  def is_numeric? string
    true if Float(string) rescue false
  end

end
