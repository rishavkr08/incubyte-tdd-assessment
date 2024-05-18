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
    delimiter = get_delimiters(numbers)
    numbers = numbers.split("\n", 2).last if numbers.start_with?('//')

    split_numbers = numbers.split(/#{delimiter}/)

    split_numbers.map(&:to_i)
  end

  def get_delimiters(numbers)
    delimiters = /,|\n/
    if numbers.start_with?('//')
      delimiters = numbers[2..].scan(/\[([^\[\]]+)\]/).flatten.map { |d| Regexp.escape(d) }.join('|')
    end
    delimiters
  end

  def check_for_negative_numbers(numbers)
    negatives = numbers.select(&:negative?)

    raise "Negative numbers not allowed: #{negatives.join(',')}" unless negatives.empty?
  end
end
