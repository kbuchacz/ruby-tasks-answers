class ConditionValidator

  def call(boolean)
    (boolean).if_true { puts "YES" }.if_false { puts "NO" }
  end

end
