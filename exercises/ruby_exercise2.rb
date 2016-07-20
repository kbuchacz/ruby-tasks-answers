module RubyExercise2

  def self.sum_args(*args)
    args.inject(:+)
  end

end
