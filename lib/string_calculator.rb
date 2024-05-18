# frozen_string_literal: true

# String calculator with a add method that accepts string
class StringCalculator
  def self.add(numbers)
    return 0 if numbers.nil?

    delimiter = /,|\n|;/

    return numbers.to_i if numbers.split(delimiter).count < 2

    digits = numbers.split(delimiter).map(&:to_i)
    digits.reduce(0, :+)
  end
end
