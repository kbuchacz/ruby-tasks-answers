module RubyExercise3

  def self.to_camel_case(string)
    output = string.split('_').map{|exp| exp.capitalize}.join
    output[0] = output[0].downcase
    output
  end

  def self.to_capital_case(string)
    string.split('_').map{|e| e.capitalize}.join
  end

end
