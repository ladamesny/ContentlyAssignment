
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

  def test_process_equation
    # Given
    equation = "5 + 2"
    stack = ['5', '+', '2']

    # When
    calculator=Calculator.new(equation)
    calculator.process_equation

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


  def test_validity_of_equations
    equation_1 = "( 5 + 2 )"
    calculator_1 = Calculator.new(equation_1)
    calculator_1.run_calculator

    equation_2 = " 5 + 2 )"
    calculator_2 = Calculator.new(equation_2)
    calculator_2.run_calculator

    equation_3 = " ( 5 + 2"
    calculator_3 = Calculator.new(equation_3)
    calculator_3.run_calculator

    equation_4 = " ) 5 + 2 ("
    calculator_4 = Calculator.new(equation_4)
    calculator_4.run_calculator

    equation_5 = " () 5 + 2 ("
    calculator_5 = Calculator.new(equation_5)
    calculator_5.run_calculator

    equation_6 = " () 5 + 2 ()"
    calculator_6 = Calculator.new(equation_6)
    calculator_6.run_calculator

    equation_7 = " 5 ( 5 + 2 )"
    calculator_7 = Calculator.new(equation_7)
    calculator_7.run_calculator

    equation_8 = " ( 5 ( 5 + 2 )"
    calculator_8 = Calculator.new(equation_8)
    calculator_8.run_calculator

    equation_9 = " ( 5 )( 5 + 2 )"
    calculator_9 = Calculator.new(equation_9)
    calculator_9.run_calculator

    equation_10 = "  5 + ( 5 + 2 )"
    calculator_10 = Calculator.new(equation_10)
    calculator_10.run_calculator

    equation_11 = " ( 5 + ( 5 + 2 )"
    calculator_11 = Calculator.new(equation_11)
    calculator_11.run_calculator

    assert_equal(calculator_1.equation_is_valid?, true )
    assert_equal(calculator_2.equation_is_valid?, false )
    assert_equal(calculator_3.equation_is_valid?, false )
    assert_equal(calculator_4.equation_is_valid?, false )
    assert_equal(calculator_5.equation_is_valid?, false )
    assert_equal(calculator_6.equation_is_valid?, true )
    assert_equal(calculator_7.equation_is_valid?, true )
    assert_equal(calculator_8.equation_is_valid?, false )
    assert_equal(calculator_9.equation_is_valid?, true )
    assert_equal(calculator_10.equation_is_valid?, true )
    assert_equal(calculator_11.equation_is_valid?, false )
  end

  def test_calculation_equations
    equation_1 = '( 5 + 2 )'
    calculator_1 = Calculator.new(equation_1)
    calculator_1.run_calculator

    equation_2 = '5 * ( 5 + 2 )'
    calculator_2 = Calculator.new(equation_2)
    calculator_2.run_calculator

    equation_3 = '( 5 ) * ( 5 + 2 )'
    calculator_3 = Calculator.new(equation_3)
    calculator_3.run_calculator

    equation_4 = '5 + ( 5 + 2 )'
    calculator_4 = Calculator.new(equation_4)
    calculator_4.run_calculator

    equation_5 = '( ( 5 ) + ( 5 + 2 ) )'
    calculator_5 = Calculator.new(equation_5)
    calculator_5.run_calculator

    equation_6 = '5 + ( 5 - 2 )'
    calculator_6 = Calculator.new(equation_6)
    calculator_6.run_calculator

    equation_7 = '( ( 5 ) - ( 5 - -2 ) )'
    calculator_7 = Calculator.new(equation_7)
    calculator_7.run_calculator

    equation_8 = '( ( 5 ) - ( 5 + -2 ) )'
    calculator_8 = Calculator.new(equation_8)
    calculator_8.run_calculator

    assert_equal(calculator_1.answer, 7 )
    assert_equal(calculator_2.answer, 35 )
    assert_equal(calculator_3.answer, 35 )
    assert_equal(calculator_4.answer, 12 )
    assert_equal(calculator_5.answer, 12 )
    assert_equal(calculator_6.answer, 8 )
    assert_equal(calculator_7.answer, -2 )
    assert_equal(calculator_8.answer, 2 )

  end


end
