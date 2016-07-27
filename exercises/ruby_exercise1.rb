module RubyExercise1

  def self.valid_email?(email)
    email =~ /\A([\w+\-]\.?)+\w@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  end
end
