require_relative "spec_helper"
require_relative "../exercises/ruby_exercise3"

describe "RubyExercise3" do

  let(:sentence) { Faker::Lorem.sentence.gsub(/\s+/, "_").downcase }

  it "string does not have camelize/camelcase methods defined" do
    # to make sure that some active supoort modules are not included
    expect("string".respond_to?(:camelize)).to eql(false)
    expect("string".respond_to?(:camelcase)).to eql(false)
  end

  context "#to_camel_case" do

    it "changes the case properly" do
      expect(RubyExercise3.to_camel_case("this_is_string")).to eql("thisIsString")
      expect(RubyExercise3.to_camel_case("other_test")).to eql("otherTest")
      long_string = "some_very_long_string_with_many_under_scores"
      expect(RubyExercise3.to_camel_case(long_string)).to eql("someVeryLongStringWithManyUnderScores")
      expect(RubyExercise3.to_camel_case(long_string)).to_not match("_")
      expect(RubyExercise3.to_camel_case("single")).to eql("single")
    end

  end


  context "#to_capital_case" do

    it "changes the case properly" do
      expect(RubyExercise3.to_capital_case("this_is_string")).to eql("ThisIsString")
      expect(RubyExercise3.to_capital_case("other_test")).to eql("OtherTest")
      long_string = "some_very_long_string_with_many_under_scores"
      expect(RubyExercise3.to_capital_case(long_string)).to eql("SomeVeryLongStringWithManyUnderScores")
      expect(RubyExercise3.to_capital_case(long_string)).to_not match("_")
      expect(RubyExercise3.to_capital_case("single")).to eql("Single")
    end

  end
end
