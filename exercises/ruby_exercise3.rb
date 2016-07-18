require_relative "../lib/base_renderer"

module RubyExercise3

  class TextRenderer < BaseRenderer
    def render(text)
      super()
      puts text
    end
  end

end
