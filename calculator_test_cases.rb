
require_relative "calculator"
require "test/unit"

class TestCalculator < Test::Unit::TestCase

  def test_calculator_class
    equation = "5 + 2"
    calculator=Calculator.new(equation)
    assert_equal(calculator.class.to_s, 'Calculator' )
  end

  def test_equation_initialization
    equation = "5 + 2"
    calculator=Calculator.new(equation)
    assert_equal(calculator.original_equation, equation )
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

    # TEST OF VALID SYNTAX
    equation_1 = "( 5 + 2 )"
    calculator_1 = Calculator.new(equation_1)
    calculator_1.run_calculator
    assert_equal(calculator_1.equation_is_valid?, true )


    equation_2 = "() 5 + 2 ()"
    calculator_2 = Calculator.new(equation_2)
    calculator_2.run_calculator
    assert_equal(calculator_2.equation_is_valid?, true )

    equation_3 = "5 ( 5 + 2 )"
    calculator_3 = Calculator.new(equation_3)
    calculator_3.run_calculator
    assert_equal(calculator_3.equation_is_valid?, true )

    equation_4 = "( 5 )( 5 + 2 )"
    calculator_4 = Calculator.new(equation_4)
    calculator_4.run_calculator
    assert_equal(calculator_4.equation_is_valid?, true )

    equation_5 = "5 + ( 5 + 2 )"
    calculator_5 = Calculator.new(equation_5)
    calculator_5.run_calculator
    assert_equal(calculator_5.equation_is_valid?, true )

    equation_6 = "( 5 ) * ( 5 + 2 )"
    calculator_6 = Calculator.new(equation_6)
    calculator_6.run_calculator
    assert_equal(calculator_6.equation_is_valid?, true )

    equation_7 = "( 300 / 30 - 5 ) / 5 * ( 5 + 3 )"
    calculator_7 = Calculator.new(equation_7)
    calculator_7.run_calculator
    assert_equal(calculator_7.equation_is_valid?, true )

    equation_8 = "( 300 / 30 - 5 ) / ( 5 * ( 5 + 3 ) )"
    calculator_8 = Calculator.new(equation_8)
    calculator_8.run_calculator
    assert_equal(calculator_8.equation_is_valid?, true )

    # TEST FOR INVALID SYNTAX
    equation_9 = "5 + 2 )"
    calculator_9 = Calculator.new(equation_9)
    calculator_9.run_calculator
    assert_equal(calculator_9.equation_is_valid?, false )

    equation_10 = "( 5 + 2"
    calculator_10 = Calculator.new(equation_10)
    calculator_10.run_calculator
    assert_equal(calculator_10.equation_is_valid?, false )

    equation_11 = ") 5 + 2 ("
    calculator_11 = Calculator.new(equation_11)
    calculator_11.run_calculator
    assert_equal(calculator_11.equation_is_valid?, false )

    equation_12 = "() 5 + 2 ("
    calculator_12 = Calculator.new(equation_12)
    calculator_12.run_calculator
    assert_equal(calculator_12.equation_is_valid?, false )

    equation_13 = "( 5 ( 5 + 2 )"
    calculator_13 = Calculator.new(equation_13)
    calculator_13.run_calculator
    assert_equal(calculator_13.equation_is_valid?, false )

    equation_14 = "( 5 + ( 5 + 2 )"
    calculator_14 = Calculator.new(equation_14)
    calculator_14.run_calculator
    assert_equal(calculator_14.equation_is_valid?, false )

  end

  def test_calculation_equations
    equation_1 = '( 5 + 2 )'
    calculator_1 = Calculator.new(equation_1)
    calculator_1.run_calculator
    assert_equal(calculator_1.answer, 7 )

    equation_2 = '5 * ( 5 + 2 )'
    calculator_2 = Calculator.new(equation_2)
    calculator_2.run_calculator
    assert_equal(calculator_2.answer, 35 )

    equation_3 = '( 5 ) * ( 5 + 2 )'
    calculator_3 = Calculator.new(equation_3)
    calculator_3.run_calculator
    assert_equal(calculator_3.answer, 35 )

    equation_4 = '5 + ( 5 + 2 )'
    calculator_4 = Calculator.new(equation_4)
    calculator_4.run_calculator
    assert_equal(calculator_4.answer, 12 )

    equation_5 = '( ( 5 ) + ( 5 + 2 ) )'
    calculator_5 = Calculator.new(equation_5)
    calculator_5.run_calculator
    assert_equal(calculator_5.answer, 12 )

    equation_6 = '5 + ( 5 - 2 )'
    calculator_6 = Calculator.new(equation_6)
    calculator_6.run_calculator
    assert_equal(calculator_6.answer, 8 )

    equation_7 = '( ( 5 ) - ( 5 - -2 ) )'
    calculator_7 = Calculator.new(equation_7)
    calculator_7.run_calculator
    assert_equal(calculator_7.answer, -2 )

    equation_8 = '( ( 5 ) - ( 5 + -2 ) )'
    calculator_8 = Calculator.new(equation_8)
    calculator_8.run_calculator
    assert_equal(calculator_8.answer, 2 )

    equation_9 = '( ( 25 ) / ( 5 ) )'
    calculator_9 = Calculator.new(equation_9)
    calculator_9.run_calculator
    assert_equal(calculator_9.answer, 5 )

    equation_10 = "( ( 5 ) ( 5 * 10 ) )"
    calculator_10 = Calculator.new(equation_10)
    calculator_10.run_calculator
    assert_equal(calculator_10.answer, 250 )

    equation_11 = " ( 5 ) * ( 5 + 2 )"
    calculator_11 = Calculator.new(equation_11)
    calculator_11.run_calculator
    assert_equal(calculator_11.answer, 35 )

    equation_12 = "( 300 / (15 - 5 ) ) / ( 5 * ( 5 + 1 ) )"
    calculator_12 = Calculator.new(equation_12)
    calculator_12.run_calculator
    assert_equal(calculator_12.answer, 1 )

    equation_13 = "( 300 / (15 - 5 ) ) /  5 * ( 5 + 1 ) "
    calculator_13 = Calculator.new(equation_13)
    calculator_13.run_calculator
    assert_equal(calculator_13.answer, 36 )

    equation_14 = "6 + 4 * 3 - 10 / 5"
    calculator_14 = Calculator.new(equation_14)
    calculator_14.run_calculator
    assert_equal(calculator_14.answer, 16 )

    equation_15 = "5 ( 4 + 3 * 2 ) - ( 9 - 28 / 7 ) / 5 "
    calculator_15 = Calculator.new(equation_15)
    calculator_15.run_calculator
    assert_equal(calculator_15.answer, 49 )

    equation_16 = "( 32 − 3^3 ÷ 9 x 10 )^5  − 4^2 ÷ 8 + 3^2"
    calculator_16 = Calculator.new(equation_16)
    calculator_16.run_calculator
    assert_equal(calculator_16.answer, 39 )

  end
end
