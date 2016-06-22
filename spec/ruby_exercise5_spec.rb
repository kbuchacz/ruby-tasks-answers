require_relative "spec_helper"
require_relative "../exercises/ruby_exercise5"
require_relative "../lib/condition_validator"

describe "RubyExercise5" do
  context "ConditionChecker#check_condition" do

    it "outputs YES if true" do
      expect { ConditionValidator.new.call(true) }.to output(/YES/).to_stdout
    end

    it "outputs NO if true" do
      expect { ConditionValidator.new.call(false) }.to output(/NO/).to_stdout
    end

  end
end
