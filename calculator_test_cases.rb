
require_relative "calculator"
require "test/unit"

class TestCalculator < Test::Unit::TestCase

  def test_simple
    equation = "5 + 2"
    calculator=Calculator.new(equation)
    assert_equal(calculator.class.to_s, 'Calculator' )
  end

  def test_equation_initialization
    equation = "5 + 2"
    calculator=Calculator.new(equation)
    assert_equal(calculator.equation, equation )
  end

  # Stack Parser Tests
  # The stack attribute will hold each element in order

  def test_process_stack
    # Given
    equation = "5 + 2"
    stack = ['5', '+', '2']

    # When
    calculator=Calculator.new(equation)
    calculator.process_stack

    # Then
    assert_equal(calculator.stack, stack )
  end

  def test_parenthesis_valid_equation
    # Given
    equation = "( 5 + 2 )"
    # When
    calculator=Calculator.new(equation)
    calculator.run_calculator
    # Then
    assert_equal(calculator.equation_is_valid?, true)
  end


  def test_validity_of_equation
    equation_1 = "( 5 + 2 )"
    calculator_1 = Calculator.new(equation_1)
    calculator_1.run_calculator

    equation_2 = " 5 + 2 )"
    calculator_2 = Calculator.new(equation_2)
    calculator_2.run_calculator

    assert_equal(calculator_1.equation_is_valid?, true )
    assert_equal(calculator_2.equation_is_valid?, false )
  end


end
