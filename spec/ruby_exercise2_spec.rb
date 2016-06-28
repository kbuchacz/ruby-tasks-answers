require_relative "spec_helper"
require_relative "../exercises/ruby_exercise2"

describe "RubyExercise2" do
  context "#leap_year?" do

    it "returns true for leap year" do
      expect(RubyExercise2.leap_year?(1996)).to be_truthy
    end

    it "returns true for leap year" do
      expect(RubyExercise2.leap_year?(2400)).to be_truthy
    end

    it "returns true for leap year" do
      expect(RubyExercise2.leap_year?(leap_year)).to be_truthy
    end

    it "returns false for leap year" do
      expect(RubyExercise2.leap_year?(1900)).to be_falsy
    end

    it "returns false for not leap year" do
      expect(RubyExercise2.leap_year?(1998)).to be_falsy
    end

    it "returns false for not leap year" do
      expect(RubyExercise2.leap_year?(1997)).to be_falsy
    end

    it "returns false for not leap year" do
      expect(RubyExercise2.leap_year?(1900)).to be_falsy
    end

    it "returns false for not leap year" do
      expect(RubyExercise2.leap_year?(not_leap_year)).to be_falsy
    end
  end
end
