require_relative "spec_helper"
require_relative "../exercises/ruby_exercise4"

describe "RubyExercise4" do
  context "#prepare_image_details" do

    let(:image_id)  { rand(100) }

    let(:results)  { RubyExercise4.prepare_image_details(image_id, input_data) }

    let(:thumbnail) { results.detect { |r| r[:image_type] == "thumbnail" } }
    let(:medium) { results.detect { |r| r[:image_type] == "medium" } }
    let(:original) { results.detect { |r| r[:image_type] == "original" } }
    let(:original_width) { [2048, 1920, 1600, 1280, 960].sample }
    let(:original_height) { [1152, 1080, 900, 720, 540].sample }

    let(:thumbnail_dimension) { 40 + rand(50) }


    let(:medium_width) { [1600, 1280, 960, 640, 320].sample }
    let(:medium_height) { [900, 720, 540, 480, 360].sample }

    let(:input_data) do
      {
        "original" => {"format"=>"jpeg", "geometry"=>"#{original_width}x#{original_height}"},
        "medium" => {"format"=>"jpg",  "geometry"=>"#{medium_width}x#{medium_height}"},
        "thumbnail" => {"format"=>"png", "geometry"=>"#{thumbnail_dimension}x#{thumbnail_dimension}"}
      }
    end

    let(:original_expected_hash) do
      {
        width: original_width, height: original_height, content_type: "image/jpeg", image_type: "original",
        image_url: "http://images_server.com/images/#{image_id}/original.jpeg"
      }
    end

    let(:medium_expected_hash) do
      {
        width: medium_width, height: medium_height, content_type: "image/jpeg", image_type: "medium",
        image_url: "http://images_server.com/images/#{image_id}/medium.jpg"
      }
    end

    let(:thumbnail_expected_hash) do
      {
        width: thumbnail_dimension, height: thumbnail_dimension, content_type: "image/png", image_type: "thumbnail",
        image_url: "http://images_server.com/images/#{image_id}/thumbnail.png"
      }
    end


    it "each hash should have valid data" do
      expect(original).to eql(original_expected_hash)
      expect(medium).to eql(medium_expected_hash)
      expect(thumbnail).to eql(thumbnail_expected_hash)
    end


    it "should retuns array with valid size" do
      expect(results.size).to eql(3)
    end

    it "should return array of hashes with valid keys" do
      results.each do |result|
        expect(result.class).to eql(Hash)
        expect(result.keys).to match_array([:image_type, :width, :height, :content_type, :image_url])
      end
    end

    context "randomized image type" do
      let(:random_image_type) { [*('a'..'z')].sample(12).join }
      let(:input_data) do
        {
          random_image_type => {"format"=>"jpeg", "geometry"=>"#{original_width}x#{original_height}"},
        }
      end

      let(:expected_result) do
        {
          width: original_width, height: original_height, content_type: "image/jpeg", image_type: random_image_type,
          image_url: "http://images_server.com/images/#{image_id}/#{random_image_type}.jpeg"
        }
      end

      let(:results)  { RubyExercise4.prepare_image_details(image_id, input_data) }
      it "returns valid transofrmed data" do
        expect(results).to  eql([expected_result])
      end
    end

  end
end
