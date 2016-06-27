require "rails_helper"

describe "MoviesController", type: :request do

  describe "GET #index" do

    context "when some movies exist" do
      let!(:movie1) { create(:movie_with_genres) }
      let!(:movie2) { create(:movie_with_genres) }

      let(:movies_from_response)  { response_body_as_json }
      let(:required_movie_attributes) do
        [
          "id", "title", "year", "description",
          "runtime", "rate", "votes_count"
        ].sort
      end

      it "returns request not acceptable for invalid format" do
        get movies_path
        expect(response.status).to eql(406)
        expect(response_body_as_json).to match(request_not_acceptable_error)
      end

      it "responds with JSON" do
        get movies_path, format: :json
        expect(response.content_type).to match(/json/)
      end

      it "should have proper structure" do
        get movies_path, format: :json
        expect(movies_from_response).to have_key("movies")
        expect(movies_from_response).to have_key("meta")
        expect(movies_from_response["meta"]).to have_key("count")
        expect(movies_from_response["meta"]["count"]).to eql(2)
        movies_from_response["movies"].each do |movie_from_response|
          expect(movie_from_response.keys.sort).to eql(required_movie_attributes)
        end
      end
    end

    context "when no movies exist" do

      let(:movies_from_response)  { response_body_as_json }

      it "responds with JSON" do
        get movies_path, format: :json
        expect(response.content_type).to match(/json/)
      end

      it "reponds with empty movies list" do
        get movies_path, format: :json
        expect(movies_from_response).to have_key("movies")
        expect(movies_from_response).to have_key("meta")
        expect(movies_from_response["meta"]).to have_key("count")
        expect(movies_from_response["meta"]["count"]).to eql(0)
      end
    end
  end

  describe "GET #show" do
    let(:genre) { create(:genre) }
    let(:movie) { create(:movie, genres: [genre]) }

    let(:movie_from_response)  { response_body_as_json }

    let(:movie_expected_response) do
      build_expected_movie_response(movie: movie)
    end

    it "returns request not acceptable for invalid format" do
      get movie_path(movie.id)
      expect(response.status).to eql(406)
      expect(response_body_as_json).to match(request_not_acceptable_error)
    end

    it "responds with JSON" do
      get movie_path(movie.id), format: :json
      expect(response.content_type).to match(/json/)
    end

    it "retrieves a specific movie with valid data" do
      get movie_path(movie.id), format: :json
      expect(movie_from_response).to eq(movie_expected_response)
    end

    it "responds with error when resource not exists" do
      get movie_path(-1), format: :json
      expect(response.content_type).to match(/json/)
      expect(response_body_as_json).to match(record_not_found_error)
    end

  end

  describe "POST #create" do

    it "returns request not acceptable for invalid format" do
      post movies_path
      expect(response.status).to eql(406)
      expect(response_body_as_json).to match(request_not_acceptable_error)
    end

    context "when movie data root is missing" do
      let(:error_from_response)  { response_body_as_json }

      it "returns error 400 bad request" do
        post movies_path, format: :json
        expect(response.status).to eql(400)
        expect(error_from_response).to match(bad_request_error("movie"))
      end
    end

    context "when params are valid" do

      let(:valid_movie_params) { attributes_for(:movie) }
      let(:movie_from_response)  { response_body_as_json["movie"] }

      it "should create valid movie" do
        post movies_path, format: :json, movie: valid_movie_params
        expect(response.status).to eq(201)
        expect(movie_from_response["title"]).to eql(valid_movie_params[:title])
        expect(movie_from_response["description"]).to eql(valid_movie_params[:description])
        expect(movie_from_response["year"]).to eql(valid_movie_params[:year])
        expect(movie_from_response["runtime"]).to eql(valid_movie_params[:runtime])
        expect(movie_from_response["rate"]).to eql("0.0")
        expect(movie_from_response["votes_count"]).to eql(0)
      end
    end

    context "when params are invalid" do

      let(:invalid_movie_params) do
        {
          title: nil,
          description: nil,
          year: 1899,
          runtime: 0
        }
      end

      it "should return 422 status and valid error structure" do
        post movies_path, format: :json, movie: invalid_movie_params
        expect(response.status).to eq(422)
        expect(response_body_as_json).to have_key("errors")
        expect(response_body_as_json["errors"]).to_not be_empty

        response_body_as_json["errors"].each do |error|
          expect(error.keys).to match_array(["code", "message", "status", "invalid_field"])
          expect(error["code"]).to eql("VALIDATION_ERROR")
          expect(error["status"]).to eql(422)
          expect(error["status"]).to_not be_blank
        end
      end

      it "should have errors for all invalid fields" do
        post movies_path, format: :json, movie: invalid_movie_params
        invalid_field_names = response_body_as_json["errors"].map { |error| error["invalid_field"] }.uniq
        expect(invalid_field_names).to match_array(["title", "description", "year", "runtime"])
      end

      it "is invalid with year exceeding range" do
        year_exceeding_valid_range =  Time.now.year + 4
        post movies_path, format: :json, movie: invalid_movie_params.merge({year: year_exceeding_valid_range})
        invalid_field_names = response_body_as_json["errors"].map { |error| error["invalid_field"] }.uniq
        expect(invalid_field_names).to match_array(["title", "description", "year", "runtime"])
      end

    end
  end

  describe "PUT #update" do
    let(:movie) { create(:movie_with_genres) }

    it "returns request not acceptable for invalid format" do
      put movie_path(movie.id)
      expect(response.status).to eql(406)
      expect(response_body_as_json).to match(request_not_acceptable_error)
    end

    context "when movie data root is missing" do
      let(:error_from_response)  { response_body_as_json }

      it "returns error 400 bad request" do
        put movie_path(movie.id), format: :json
        expect(response.status).to eql(400)
        expect(error_from_response).to match(bad_request_error("movie"))
      end
    end

    context "when paras are valid " do
      let(:new_title) { Faker::Book.title }
      let(:new_description) { Faker::Lorem.sentence(10) }

      let(:movie_update_params) do
        {
          title: new_title,
          description: new_description
        }
      end

      let(:movie_expected_response) do
        build_expected_movie_response(movie: movie.reload)
      end

      it "responds with JSON" do
        put movie_path(movie.id), format: :json, movie: movie_update_params
        expect(response.content_type).to match(/json/)
      end

      it "updates movie" do
        put movie_path(movie.id), format: :json, movie: movie_update_params
        expect(response.status).to eq(200)
        expect(response_body_as_json["movie"]["title"]).to eq(new_title)
        expect(response_body_as_json["movie"]["description"]).to eq(new_description)
        expect(response_body_as_json).to eq(movie_expected_response)
      end

      it "does not update rate and votes count" do
        before_update_attributes = movie.attributes
        put movie_path(movie.id),format: :json, movie: { rate: "7.7", votes_count: "86" }
        expect(response_body_as_json["movie"]["rate"]).to eq(before_update_attributes["rate"])
        expect(response_body_as_json["movie"]["votes_count"]).to eq(before_update_attributes["votes_count"])
      end
    end


    context "when params are invalid" do

      let(:invalid_update_params) do
        {
          title: nil,
          description: nil,
          runtime: 0,
        }
      end


      it "should return 422 status and proper error structure" do
        put movie_path(movie.id), format: :json, movie: invalid_update_params

        expect(response.status).to eq(422)
        expect(response_body_as_json).to have_key("errors")
        expect(response_body_as_json["errors"]).to_not be_empty

        response_body_as_json["errors"].each do |error|
          expect(error.keys).to match_array(["code", "message", "status", "invalid_field"])
          expect(error["code"]).to eql("VALIDATION_ERROR")
          expect(error["status"]).to eql(422)
          expect(error["status"]).to_not be_blank
        end
      end

      it "should have errors for all invalid fields" do
        put movie_path(movie.id), format: :json, movie: invalid_update_params
        invalid_field_names = response_body_as_json["errors"].map { |error| error["invalid_field"] }.uniq
        expect(invalid_field_names).to match_array(["title", "description", "runtime"])
      end

    end

  end


  describe "POST #rate" do
    let(:movie) { create(:movie) }
    let(:new_vote) { "7.8" }
    let(:invalid_vote) { "16.0" }
    let(:movie_expected_response) do
      build_expected_movie_response(movie: movie.reload)
    end
    let(:movie_with_rate) { create(:movie, rate: "7.5", votes_count: 10) }

    it "returns request not acceptable for invalid format" do
      post rate_movie_path(movie.id), movie: { vote: new_vote }
      expect(response.status).to eql(406)
      expect(response_body_as_json).to match(request_not_acceptable_error)
    end

    it "responds with json" do
      post rate_movie_path(movie.id), format: :json, movie: { vote: new_vote }
      expect(response.content_type).to match(/json/)
    end

    it "returns valid movie" do
      post rate_movie_path(movie.id), format: :json, movie: { vote: new_vote }
      expect(response_body_as_json).to eq(movie_expected_response)
    end

    it "accepts a new vote" do
      post rate_movie_path(movie.id), format: :json, movie: { vote: new_vote }
      expect(response_body_as_json["movie"]["rate"]).to eq("7.8")
    end

    it "calculates new up vote properly" do
      post rate_movie_path(movie_with_rate.id), format: :json, movie: { vote: "8.1" }
      expect(response_body_as_json["movie"]["rate"]).to eq("7.6")
    end

    it "calculates new down vote properly" do
      post rate_movie_path(movie_with_rate.id), format: :json, movie: { vote: "4.1" }
      expect(response_body_as_json["movie"]["rate"]).to eq("7.2")
    end

    context "when movie data root is missing" do
      let(:error_from_response)  { response_body_as_json }

      it "returns error 400 bad request" do
        post rate_movie_path(movie_with_rate.id), format: :json
        expect(response.status).to eql(400)
        expect(error_from_response).to match(bad_request_error("movie"))
      end
    end

    context "when invalid vote is provided" do

      it "returns errors object with poper structure" do
        post rate_movie_path(movie_with_rate.id), format: :json, movie: { vote: invalid_vote }
        expect(response.status).to eq(422)
        expect(response_body_as_json).to have_key("errors")
        expect(response_body_as_json["errors"]).to_not be_empty

        response_body_as_json["errors"].each do |error|
          expect(error.keys).to match_array(["code", "message", "status", "invalid_field"])
          expect(error["code"]).to eql("VALIDATION_ERROR")
          expect(error["status"]).to eql(422)
          expect(error["status"]).to_not be_blank
        end
      end

      it "returns error for rate field" do
        post rate_movie_path(movie_with_rate.id), format: :json, movie: { vote: invalid_vote }
        invalid_field_names = response_body_as_json["errors"].map { |error| error["invalid_field"] }.uniq
        expect(invalid_field_names).to match_array(["rate"])
      end
    end
  end
end
