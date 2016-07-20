module RubyExercise4

  def self.prepare_image_details(image_id, image_data)
    image_data.inject([]) do |array, (image_type, image_details)|
      array << { image_type: image_type }.merge!(parse_format_details(image_id, image_type, image_details))
    end
  end

  def self.parse_format_details(image_id, image_type, image_details)
    geometry = image_details.fetch("geometry").split('x').map(&:to_i)
    image_format = image_details.fetch("format")

    {
      width: geometry.first,
      height: geometry.last,
      image_url: generate_url(image_id, image_type, image_format),
      content_type: format_to_conent_type[image_format]
    }
  end

  def self.generate_url(image_id, image_type, format)
    "http://images_server.com/images/#{image_id}/#{image_type}.#{format}"
  end

  def self.format_to_conent_type
    {
      "jpg" => "image/jpeg",
      "jpeg" => "image/jpeg",
      "png" => "image/png",
    }
  end

end
