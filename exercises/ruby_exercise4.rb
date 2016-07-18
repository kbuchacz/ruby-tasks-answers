module RubyExercise4
  class FileProcessor

    attr_reader :processed_files

    def initialize
      @processed_files = []
    end

    def get_file_content(file_path)
      content = ""
      read_contents = lambda do |file|
        puts "Read content"
        content << file.read
        return content
      end
      with_file(file_path, &read_contents)
      puts "Content received: #{content}"
    end


    private


    def with_file(file_path, &processor)
      puts "Open file"
      file = File.open(file_path, "r")
      processor.call(file)
      processed_files << file
      puts "Close file"
      file.close
    end
  end
end