require_relative "spec_helper"
require_relative "../exercises/ruby_exercise2"

describe "RubyExercise2" do
  context "#sum_args" do

    it "sums arguments" do
      expect(RubyExercise2.sum_args("a", "b", "c", "d", "e", "f")).to eql("abcdef")
    end

    it "sums arguments" do
      expect(RubyExercise2.sum_args(3, 7, 2, 8, 3, 27)).to eql(50)
    end

    it "sums arguments" do
      expect(RubyExercise2.sum_args([3],[7],[2],[8],[3],[27])).to eql([3, 7, 2, 8, 3, 27])
    end

    it "sums arguments" do
      expect(RubyExercise2.sum_args(7.0, 12.0, 4.1, 7.3).round(2)).to eql(30.4)
    end

    it "sums arguments" do
      one_year_in_seconds = 24 * 3600 * 365
      args = Time.local(2001, 1, 1), one_year_in_seconds
      expect(RubyExercise2.sum_args(*args).strftime("%Y-%m-%d")).to eql("2002-01-01")
    end

  end

end
