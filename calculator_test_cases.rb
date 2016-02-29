
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
    assert_equal(true, calculator.equation_is_valid?)
  end

  def test_multiplication_operators
    equation_star = " 5 * 2 "
    calculator_star = Calculator.new(equation_star)
    calculator_star.run_calculator
    assert_equal(calculator_star.answer, 10)

    equation_x = " 5 x 3 "
    calculator_x = Calculator.new(equation_x)
    calculator_x.run_calculator
    assert_equal(15, calculator_x.answer )
  end

  def test_division_operators
    equation_star = " 10 / 2 "
    calculator_star = Calculator.new(equation_star)
    calculator_star.run_calculator
    assert_equal(5, calculator_star.answer )

    equation_x = " 15 ÷ 5 "
    calculator_x = Calculator.new(equation_x)
    calculator_x.run_calculator
    assert_equal(3, calculator_x.answer )
  end

  def test_subtraction_operators
    equation_star = " 10 - 2 "
    calculator_star = Calculator.new(equation_star)
    calculator_star.run_calculator
    assert_equal(8, calculator_star.answer )

    # Slightly different 'subtract' operator I found while I was looking for equation examples.
    equation_x = " 15 − 5 "
    calculator_x = Calculator.new(equation_x)
    calculator_x.run_calculator
    assert_equal(10, calculator_x.answer )
  end

  def test_exponent_operators
    equation_star = " 5 ** 2 "
    calculator_star = Calculator.new(equation_star)
    calculator_star.run_calculator
    assert_equal(25, calculator_star.answer )

    # Slightly different 'subtract' operator I found while I was looking for equation examples.
    equation_x = " 3^2 "
    calculator_x = Calculator.new(equation_x)
    calculator_x.run_calculator
    assert_equal(9, calculator_x.answer )
  end

  def test_validity_of_equations

    # TEST OF VALID SYNTAX
    equation_1 = "( 5 + 2 )"
    calculator_1 = Calculator.new(equation_1)
    calculator_1.run_calculator
    assert_equal(true,calculator_1.equation_is_valid?)


    equation_2 = "() 5 + 2 ()"
    calculator_2 = Calculator.new(equation_2)
    calculator_2.run_calculator
    assert_equal(true, calculator_2.equation_is_valid? )

    equation_3 = "5 ( 5 + 2 )"
    calculator_3 = Calculator.new(equation_3)
    calculator_3.run_calculator
    assert_equal(true, calculator_3.equation_is_valid? )

    equation_4 = "( 5 )( 5 + 2 )"
    calculator_4 = Calculator.new(equation_4)
    calculator_4.run_calculator
    assert_equal(true, calculator_4.equation_is_valid? )

    equation_5 = "5 + ( 5 + 2 )"
    calculator_5 = Calculator.new(equation_5)
    calculator_5.run_calculator
    assert_equal(true, calculator_5.equation_is_valid? )

    equation_6 = "( 5 ) * ( 5 + 2 )"
    calculator_6 = Calculator.new(equation_6)
    calculator_6.run_calculator
    assert_equal(true, calculator_6.equation_is_valid? )

    equation_7 = "( 300 / 30 - 5 ) / 5 * ( 5 + 3 )"
    calculator_7 = Calculator.new(equation_7)
    calculator_7.run_calculator
    assert_equal(true, calculator_7.equation_is_valid? )

    equation_8 = "( 300 / 30 - 5 ) / ( 5 * ( 5 + 3 ) )"
    calculator_8 = Calculator.new(equation_8)
    calculator_8.run_calculator
    assert_equal(true, calculator_8.equation_is_valid? )

    # TEST FOR INVALID SYNTAX
    equation_9 = "5 + 2 )"
    calculator_9 = Calculator.new(equation_9)
    calculator_9.run_calculator
    assert_equal(false, calculator_9.equation_is_valid? )

    equation_10 = "( 5 + 2"
    calculator_10 = Calculator.new(equation_10)
    calculator_10.run_calculator
    assert_equal(false, calculator_10.equation_is_valid? )

    equation_11 = ") 5 + 2 ("
    calculator_11 = Calculator.new(equation_11)
    calculator_11.run_calculator
    assert_equal(false, calculator_11.equation_is_valid? )

    equation_12 = "() 5 + 2 ("
    calculator_12 = Calculator.new(equation_12)
    calculator_12.run_calculator
    assert_equal(false, calculator_12.equation_is_valid? )

    equation_13 = "( 5 ( 5 + 2 )"
    calculator_13 = Calculator.new(equation_13)
    calculator_13.run_calculator
    assert_equal(false, calculator_13.equation_is_valid? )

    equation_14 = "( 5 + ( 5 + 2 )"
    calculator_14 = Calculator.new(equation_14)
    calculator_14.run_calculator
    assert_equal(false, calculator_14.equation_is_valid? )


    # More complex equations

    equation_15 = "5 ( 4 + 3 * 2 ) - ( 9 - 28 / 7 ) / 5 "
    calculator_15 = Calculator.new(equation_15)
    calculator_15.run_calculator
    assert_equal(true, calculator_15.equation_is_valid?)

    equation_16 = "( 32 − 3^3 ÷ 9 x 10 )^5 − (4^2 ÷ 8 )+ 3^2"
    calculator_16 = Calculator.new(equation_16)
    calculator_16.run_calculator
    assert_equal(true, calculator_16.equation_is_valid?)
  end

  def test_calculation_equations
    equation_1 = '( 5 + 2 )'
    calculator_1 = Calculator.new(equation_1)
    calculator_1.run_calculator
    assert_equal(7, calculator_1.answer )

    equation_2 = '5 * ( 5 + 2 )'
    calculator_2 = Calculator.new(equation_2)
    calculator_2.run_calculator
    assert_equal(35, calculator_2.answer )

    equation_3 = '( 5 ) * ( 5 + 2 )'
    calculator_3 = Calculator.new(equation_3)
    calculator_3.run_calculator
    assert_equal(35, calculator_3.answer)

    equation_4 = '5 + ( 5 + 2 )'
    calculator_4 = Calculator.new(equation_4)
    calculator_4.run_calculator
    assert_equal(12, calculator_4.answer )

    equation_5 = '( ( 5 ) + ( 5 + 2 ) )'
    calculator_5 = Calculator.new(equation_5)
    calculator_5.run_calculator
    assert_equal(12, calculator_5.answer )

    equation_6 = '5 + ( 5 - 2 )'
    calculator_6 = Calculator.new(equation_6)
    calculator_6.run_calculator
    assert_equal(8, calculator_6.answer )

    equation_7 = '( ( 5 ) - ( 5 - -2 ) )'
    calculator_7 = Calculator.new(equation_7)
    calculator_7.run_calculator
    assert_equal(-2, calculator_7.answer )

    equation_8 = '( ( 5 ) - ( 5 + -2 ) )'
    calculator_8 = Calculator.new(equation_8)
    calculator_8.run_calculator
    assert_equal(2, calculator_8.answer)

    equation_9 = '( ( 25 ) / ( 5 ) )'
    calculator_9 = Calculator.new(equation_9)
    calculator_9.run_calculator
    assert_equal(5, calculator_9.answer )

    equation_10 = "( ( 5 ) ( 5 * 10 ) )"
    calculator_10 = Calculator.new(equation_10)
    calculator_10.run_calculator
    assert_equal(250, calculator_10.answer )

    equation_11 = " ( 5 ) * ( 5 + 2 )"
    calculator_11 = Calculator.new(equation_11)
    calculator_11.run_calculator
    assert_equal(35, calculator_11.answer)

    equation_12 = "( 300 / (15 - 5 ) ) / ( 5 * ( 5 + 1 ) )"
    calculator_12 = Calculator.new(equation_12)
    calculator_12.run_calculator
    assert_equal(1, calculator_12.answer )

    equation_13 = "( 300 / (15 - 5 ) ) /  5 * ( 5 + 1 ) "
    calculator_13 = Calculator.new(equation_13)
    calculator_13.run_calculator
    assert_equal(36, calculator_13.answer )

    equation_14 = "6 + 4 * 3 - 10 / 5"
    calculator_14 = Calculator.new(equation_14)
    calculator_14.run_calculator
    assert_equal(16, calculator_14.answer )

    equation_15 = "5 ( 4 + 3 * 2 ) - ( 9 - 28 / 7 ) / 5 "
    calculator_15 = Calculator.new(equation_15)
    calculator_15.run_calculator
    assert_equal(49, calculator_15.answer)

    equation_16 = "( 32 − 3^3 ÷ 9 x 10 )^5 − 4^2 ÷ 8 + 3^2"
    calculator_16 = Calculator.new(equation_16)
    calculator_16.run_calculator
    assert_equal(39, calculator_16.answer)

  end
end
