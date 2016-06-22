require_relative "spec_helper"
require_relative "../exercises/ruby_exercise3"

describe "RubyExercise3" do
  context "TextRenderer#render" do
    let(:lorem_sentence) { Faker::Lorem.sentence }
    it "renders valid text to stdout" do
      expected_output = "BaseRenderer#render\ntext"
      expect { RubyExercise3::TextRenderer.new.render("text") }.to output(/#{expected_output}/).to_stdout
    end

    it "renders valid lorem sentece to stdout" do
      expected_output = "BaseRenderer#render\n#{lorem_sentence}"
      expect { RubyExercise3::TextRenderer.new.render(lorem_sentence) }.to output(/#{expected_output}/).to_stdout
    end

    it "calls parent class render method" do
      expect_any_instance_of(RubyExercise3::BaseRenderer).to receive(:render).once
      RubyExercise3::TextRenderer.new.render("text")
    end
  end

  context "BaseRenderer" do
    it "has private render method defined" do
      expect(RubyExercise3::BaseRenderer.private_method_defined?(:render)).to eql(true)
    end
  end
end
