# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/string_calculator'

class StringCalculatorTest < Minitest::Test
  def setup
    @string_calculator = StringCalculator.new
  end

  def test_add_nil_string
    assert_equal 0, @string_calculator.add(nil)
  end

  def test_add_empty_string
    assert_equal 0, @string_calculator.add('')
  end

  def test_add_single_number
    assert_equal 10, @string_calculator.add('10')
  end

  def test_add_two_numbers
    assert_equal 30, @string_calculator.add('10, 20')
  end

  def test_add_any_numbers
    assert_equal 100, @string_calculator.add('10, 20, 30, 20, 5, 15')
  end

  def test_add_any_numbers_with_line_break_delimiter
    assert_equal 60, @string_calculator.add('10, 20, 30')
    assert_equal 60, @string_calculator.add("10 \n20, 30")
  end

  def test_add_number_with_custom_delimiter
    assert_equal 3, @string_calculator.add("//;\n1;2")
    assert_equal 3, @string_calculator.add("//@\n1@2")
    assert_equal 3, @string_calculator.add("//:\n1:2")
  end

  def test_raise_exception_for_negative_numbers
    exception = assert_raises(RuntimeError) { @string_calculator.add('10,-20, -30, 40') }
    assert_equal 'Negative numbers not allowed: -20,-30', exception.message
  end

  def test_ignore_numbers_bigger_than_thousand
    assert_equal 3, @string_calculator.add('1000,2,1')
  end

  def test_delimiter_for_any_length
    assert_equal 6, @string_calculator.add("//[***]\n1***2***3")
  end

  def test_multiple_delimiters
    assert_equal 6, @string_calculator.add("//[*][%]\n1*2%3")
  end

  def test_multiple_delimiters_for_any_length
    assert_equal 6, @string_calculator.add("//[**][%]\n1**2%3")
  end
end
