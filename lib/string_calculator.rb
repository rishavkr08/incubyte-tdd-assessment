class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?
    return numbers.to_i unless numbers.include? ","
    
    digits = numbers.split(",").map(&:to_i)
    digits.reduce(0, :+)
  end  
end
