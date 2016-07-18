module RubyExercise3

  def self.hashify(keys, values)
    result = {}
    i=0
    raise "not matching array sizes are provided" if keys.size != values.size
    while i < keys.size
      result[keys[i]] = values[i]
      i=i+1
    end
    result
  end

end
