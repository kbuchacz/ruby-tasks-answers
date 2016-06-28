require_relative "spec_helper"
require_relative "../exercises/ruby_exercise3"

describe "RubyExercise3" do
  context "#hashify" do
    let(:random_number) { rand(24) }
    let(:keys) { ("a".."z").to_a.first(random_number).shuffle }
    let(:values) { ("a".."z").to_a.first(random_number).shuffle }

    let(:result) { RubyExercise3.hashify(keys, values) }

    it "returns hash" do
      expect(result).to be_a(Hash)
    end

    it "returns hash with keys mathching provided keys" do
      expect(result.keys).to eql(keys)
    end

    it "returns hash with values mathching provided values" do
      expect(result.values).to eql(values)
    end

    it "returns expected hash" do
      expect(RubyExercise3.hashify([:a, :b], ["a", "b"])).to eql({ :a => "a", :b => "b" })
    end

    it "returns exception when arrays have different sizes" do
      expect { RubyExercise3.hashify(["x", "y", "z"], ["a", "b"]) }.to raise_error
    end

    it "returns exception when arrays have different sizes" do
      expect { RubyExercise3.hashify(["x", "y"], ["a", "b", "c"]) }.to raise_error
    end
  end

end
