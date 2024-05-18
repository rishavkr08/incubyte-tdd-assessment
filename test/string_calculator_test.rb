require 'minitest/autorun'
require_relative '../lib/string_calculator'

class StringCalculatorTest < Minitest::Test
  def test_add_empty_string
    assert_equal 0, StringCalculator.add("")
  end

  def test_add_single_number
    assert_equal 10, StringCalculator.add("10")
  end

  def test_add_two_numbers
    assert_equal 30, StringCalculator.add("10, 20")
  end

  def test_add_any_numbers
    assert_equal 100, StringCalculator.add("10, 20, 30, 20, 5, 15")
  end

  def test_add_any_numbers_with_other_delimeter
    assert_equal ["10\n 20", " 30"], "10\n 20, 30".split(",")
    assert_equal [10, 30], "10\n 20, 30".split(",").map(&:to_i)

    refute_equal 60, StringCalculator.add("10\n 20, 30")
    assert_equal 40, StringCalculator.add("10\n 20, 30")
  end
end
