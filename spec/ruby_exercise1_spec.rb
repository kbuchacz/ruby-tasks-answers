require_relative "spec_helper"
require_relative "../exercises/ruby_exercise1"

describe "RubyExercise1" do

  describe "#valid_email?" do

    it "returns true for valid email" do
      expect(RubyExercise1.valid_email?("foo.bar@example.com")).to be_truthy
    end

    it "returns true for valid email" do
      expect(RubyExercise1.valid_email?("foo.bar12345@example.com")).to be_truthy
    end

    it "returns true for valid email" do
      expect(RubyExercise1.valid_email?("54321@example.com")).to be_truthy
    end

    it "returns true for valid random email" do
      expect(RubyExercise1.valid_email?(Faker::Internet.email)).to be_truthy
    end

    it "returns true for valid email" do
      expect(RubyExercise1.valid_email?("foo.bar@example.com")).to be_truthy
    end

    it "returns true for valid email" do
      expect(RubyExercise1.valid_email?("foo.bar@12example.com")).to be_truthy
    end

    it "returns true for valid email" do
      expect(RubyExercise1.valid_email?("foo_bar.baz@example.com")).to be_truthy
    end

    it "returns false for invalid email" do
      expect(RubyExercise1.valid_email?("foo..bar@example.com")).to be_falsy
    end

    it "returns false for invalid email" do
      expect(RubyExercise1.valid_email?("foo.bar@example..com")).to be_falsy
    end

    it "returns false for invalid email" do
      expect(RubyExercise1.valid_email?(".foo@example.com")).to be_falsy
    end


    it "returns false for invalid email" do
      expect(RubyExercise1.valid_email?("foo.@example.com")).to be_falsy
    end

    it "returns false for invalid email" do
      expect(RubyExercise1.valid_email?("foo.bar@example.com.")).to be_falsy
    end

    it "returns false for invalid email" do
      expect(RubyExercise1.valid_email?("@example.com")).to be_falsy
    end

    it "returns false for invalid email" do
      expect(RubyExercise1.valid_email?("email@example@example.com")).to be_falsy
    end

  end
end
