require_relative "spec_helper"
require_relative "../exercises/ruby_exercise4"

describe "RubyExercise4" do
  context "FileProcessor#get_file_content" do
    let(:file_content) { Faker::Lorem.sentence }

    let!(:config_file) do
      config_file = Tempfile.open(["test_file", ".txt"] , ".")
      config_file.write(file_content)
      config_file.close
      config_file
    end

    let(:file_processor) { RubyExercise4::FileProcessor.new }
    let(:expected_stdout) { "Open file\nRead content\nClose file\nContent received: #{file_content}" }

    it "reads file and returns prints proper output" do
      expect { file_processor.get_file_content(config_file.path) }.to output(/#{expected_stdout}/).to_stdout
    end

    it "should have a list of closed files" do
      file_processor.get_file_content(config_file.path)

      expect(file_processor.processed_files).to_not be_empty
      expect(file_processor.processed_files.all?(&:closed?)).to be_truthy
    end
  end
end
