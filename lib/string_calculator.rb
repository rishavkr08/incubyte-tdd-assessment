# frozen_string_literal: true

# String calculator with an add method that accepts a string
class StringCalculator
  def add(numbers)
    return 0 if numbers.nil? || numbers == ''

    check_for_invalid_input(numbers)

    digits = get_digits(numbers)

    check_for_negative_numbers(digits)

    perform_operation(numbers, digits)
  end

  private

  def operators
    %w[+ * - /]
  end

  def get_digits(numbers)
    delimiter = get_delimiters(numbers)
    numbers = numbers.split("\n", 2).last if numbers.start_with?('//')

    delimiter = "\\#{delimiter}" if operators.include? delimiter
    numbers.split(/#{delimiter}/).map(&:to_i)
  end

  def get_delimiters(numbers)
    delimiters = /,|\n/
    if numbers.start_with?('//')
      return numbers.split("\n").first[2..] if numbers.split("\n").first[2..].size == 1

      delimiters = numbers[2..].scan(/\[([^\[\]]+)\]/).flatten.map { |d| Regexp.escape(d) }.join('|')
    end
    delimiters
  end

  def check_for_invalid_input(numbers)
    raise 'Invalid input' if !numbers.is_a?(String) || numbers =~ /(,|\n){2,}/ || numbers =~ /(,|\n)$/
  end

  def check_for_negative_numbers(numbers)
    negatives = numbers.select(&:negative?)

    raise "Negative numbers not allowed: #{negatives.join(',')}" unless negatives.empty?
  end

  def operations
    {
      '+' => ->(total, d) { total + d },
      '*' => ->(total, d) { total * d },
      '-' => ->(total, d) { total - d },
      '/' => ->(total, d) { total / d }
    }
  end

  def perform_operation(numbers, digits)
    delimiter = get_delimiters(numbers)
    if operators.include? delimiter
      digits[1..].reduce(digits[0], &operations[delimiter])
    else
      digits.reduce(0) { |total, d| total + (d < 1000 ? d : 0) }
    end
  end
end
