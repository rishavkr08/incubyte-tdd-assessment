# frozen_string_literal: true

# String calculator with an add method that accepts a string
class StringCalculator
  def add(numbers)
    return 0 if numbers.nil? || numbers.empty?

    check_for_invalid_input(numbers)

    digits = get_digits(numbers)

    check_for_negative_numbers(digits)

    digits.sum { |d| d < 1000 ? d : 0 }
  end

  private

  def get_digits(numbers)
    delimiter = get_delimiters(numbers)
    numbers = numbers.split("\n", 2).last if numbers.start_with?('//')

    numbers.split(/#{delimiter}/).map(&:to_i)
  end

  def get_delimiters(numbers)
    delimiters = /,|\n/
    if numbers.start_with?('//')
      delimiters = numbers[2..].scan(/\[([^\[\]]+)\]/).flatten.map { |d| Regexp.escape(d) }.join('|')
    end
    delimiters
  end

  def check_for_invalid_input(numbers)
    raise 'Invalid input' if numbers =~ /(,|\n){2,}/ || numbers =~ /(,|\n)$/
  end

  def check_for_negative_numbers(numbers)
    negatives = numbers.select(&:negative?)

    raise "Negative numbers not allowed: #{negatives.join(',')}" unless negatives.empty?
  end
end
