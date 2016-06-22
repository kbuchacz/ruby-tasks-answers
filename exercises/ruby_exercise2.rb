module RubyExercise2
  def self.replace_vowels(string)
    string.gsub!("a", "*").gsub!("e", "$")
  end
end
