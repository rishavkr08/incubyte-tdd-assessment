# frozen_string_literal: true

# String calculator with a add method that accepts string
class StringCalculator
  def self.add(numbers)
    return 0 if numbers.nil?

    delimiter = /,|\n/

    if numbers.start_with? '/'
      line_break_split = numbers.split("\n", 2)
      delimiter = Regexp.escape(line_break_split.first[2])
      numbers = line_break_split.last
    end

    nums = numbers.split(delimiter).map(&:to_i)
    negatives = nums.select(&:negative?)

    raise "Negative numbers not allowed: #{negatives.join(',')}" unless negatives.empty?

    return numbers.to_i if numbers.split(delimiter).count < 2

    digits = numbers.split(delimiter).map(&:to_i)
    digits.reduce(0, :+)
  end
end
