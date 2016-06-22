require_relative "spec_helper"
require_relative "../exercises/ruby_exercise2"

describe "RubyExercise2" do
  context "#replace_vowels" do
    let!(:random_length) { rand(1000) }
    let(:random_length_a_word) { "a" * random_length }
    let(:random_length_e_word) { "e" * random_length }
    let(:lorem_sentence)  { "Impedit adipisci velit repellendus laudantium." }

    it "replacesvowel 'a'" do
      expect(RubyExercise2.replace_vowels("hola")).to eql("hol*")
    end

    it "replaces vowel e" do
      expect(RubyExercise2.replace_vowels("hello")).to eql("h$llo")
    end

    it "replaces random length word of only a" do
      expect(RubyExercise2.replace_vowels(random_length_a_word)).to eql("*" * random_length)
    end

    it "replaces random length word of only e" do
      expect(RubyExercise2.replace_vowels(random_length_e_word)).to eql("$" * random_length)
    end

    it "replaces vowels in whole sentence" do
      expect(RubyExercise2.replace_vowels(lorem_sentence)).to eql("Imp$dit *dipisci v$lit r$p$ll$ndus l*ud*ntium.")
    end
  end

end
