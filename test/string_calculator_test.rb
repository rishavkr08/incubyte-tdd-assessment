# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/string_calculator'

class StringCalculatorTest < Minitest::Test
  def test_add_nil_string
    assert_equal 0, StringCalculator.add(nil)
  end

  def test_add_empty_string
    assert_equal 0, StringCalculator.add('')
  end

  def test_add_single_number
    assert_equal 10, StringCalculator.add('10')
  end

  def test_add_two_numbers
    assert_equal 30, StringCalculator.add('10, 20')
  end

  def test_add_any_numbers
    assert_equal 100, StringCalculator.add('10, 20, 30, 20, 5, 15')
  end

  def test_add_any_numbers_with_line_break_delimiter
    assert_equal 60, StringCalculator.add('10, 20, 30')
    assert_equal 60, StringCalculator.add("10 \n20, 30")
  end

  def test_add_number_with_custom_delimiter
    assert_equal 3, StringCalculator.add("//;\n1;2")
    assert_equal 3, StringCalculator.add("//@\n1@2")
    assert_equal 3, StringCalculator.add("//:\n1:2")
  end

  def raise_exception_for_negative_numbers
    exception = assert_raises(RuntimeError) { StringCalculator.add('10,-20, -30, 40') }
    assert_equal 'Negative numbers not allowed: -20,-30', exception.message
  end
end
