require_relative "spec_helper"
require_relative "../exercises/ruby_exercise1"

describe "RubyExercise1" do

  describe "#letter_occurance_check" do

    it "returns all 0 when empty string given" do
      expect(RubyExercise1.letter_occurance_check("")).to eql("00000000000000000000000000")
    end

    it "returns all 0 when empty string given" do
      expect(RubyExercise1.letter_occurance_check).to eql("00000000000000000000000000")
    end

    it "should return proper string" do
      expect(RubyExercise1.letter_occurance_check("abc")).to eql("11100000000000000000000000")
    end

    it "should return proper string" do
      string = " &GDFHD &#^#&DZHZDFHDHG%$&%$WYC HDFHDgdhh"
      expect(RubyExercise1.letter_occurance_check(string)).to eql("00110111000000000000001011")
    end

    it "should return proper string" do
      expect(RubyExercise1.letter_occurance_check("&*59852")).to eql("00000000000000000000000000")
    end

    it "should return proper string" do
      expect(RubyExercise1.letter_occurance_check("abcdefghijklmnopqrstuvwxyz")).to eql("11111111111111111111111111")
    end

    it "should return proper string" do
      expect(RubyExercise1.letter_occurance_check("YZ%#*v&$}#WHghHsSzq}")).to eql("00000011000000001010011011")
    end

    it "should return proper string" do
      expect(RubyExercise1.letter_occurance_check("vVvVvVvVvVvVvVvV")).to eql("00000000000000000000010000")
    end

    it "should return proper string" do
      expect(RubyExercise1.letter_occurance_check("bdfhjlnprtvxz")).to eql("01010101010101010101010101")
    end

    it "should return proper string" do
      expect(RubyExercise1.letter_occurance_check("aCeGiKmOqSuWy")).to eql("10101010101010101010101010")
    end

  end
end
