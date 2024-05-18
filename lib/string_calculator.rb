# frozen_string_literal: true

# String calculator with an add method that accepts a string
class StringCalculator
  def add(numbers)
    return 0 if numbers.nil?

    digits = get_digits(numbers)

    check_for_negative_numbers(digits)

    return 0 if digits.empty?

    digits.sum { |d| d < 1000 ? d : 0 }
  end

  private

  def get_digits(numbers)
    if numbers.start_with? '/'
      line_break_split = numbers.split("\n", 2)
      delimiter = Regexp.escape(line_break_split.first[2])
      numbers = line_break_split.last
    else
      delimiter = /,|\n/
    end

    numbers.split(delimiter).map(&:to_i)
  end

  def check_for_negative_numbers(numbers)
    negatives = numbers.select(&:negative?)

    raise "Negative numbers not allowed: #{negatives.join(',')}" unless negatives.empty?
  end
end
