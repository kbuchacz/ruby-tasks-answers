module RubyExercise1

  def self.valid_email?(email)
    result = false
    result = true if email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    result
  end

end
