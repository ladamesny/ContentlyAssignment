require_relative "validation_errors"

class Calculator

  attr_accessor :equation, :stack, :result, :equation_status, :closing_parenthases_stack, :original_equation, :final_equation

  def initialize equation
    @original_equation = equation
    @final_equation = ''
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
    self.result = eval(self.final_equation)
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
    self.stack = self.original_equation.delete(' ').split('')
    new_stack = []
    size = self.stack.size
    position = 0
    while position < size
      item = self.stack[position]
      new_stack << item
      case
      when closed_parenthasis?(item, self.stack[position+1])
        new_stack.pop
        position+=1
        return
      when implicit_multiplication?(item, self.stack[position+1]) || item == 'x'
        new_stack << '*'
      when item == '^'
        new_stack << '**'
      when item == '÷'
        new_stack << '/'
      end
      position +=1
    end
    self.stack = new_stack
    self.final_equation = new_stack.join('')
  end

  def implicit_multiplication? current_term, next_term
    (is_numeric?(current_term) && next_term == '(' ) || ( current_term == ')' && is_numeric?(next_term) ) || ( current_term == ')' && next_term == '(' )
  end

  def closed_parenthasis? current_term, next_term
    (current_term == '(' && next_term == ')')
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
