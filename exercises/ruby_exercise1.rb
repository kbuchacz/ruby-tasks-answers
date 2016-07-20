module RubyExercise1

  def self.letter_occurance_check(string = "")
    ('a'..'z').map { |letter| string.match(/#{letter}/i) ? "1" : "0"}.join
  end

end
