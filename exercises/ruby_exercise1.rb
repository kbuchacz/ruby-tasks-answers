module RubyExercise1

  def self.letter_occurance_check(string)
    result = '00000000000000000000000000'
    if string.to_s == ''
      result
    else
      string.split('').each do |c|
        i = c.ord
        if i.between?(65,90) || i.between?(97,122)
          i = i-32 if i.between?(97,122)
          result[i-65] = '1'
        end
      end
      result
    end
  end

end
