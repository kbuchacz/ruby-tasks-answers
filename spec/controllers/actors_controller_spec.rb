require "rails_helper"

describe "ActorsController", type: :request do
  describe "GET #index" do

    context "when some actorss exist" do
      let!(:actor) { create(:actor) }
      let!(:actor2) { create(:actor) }

      let(:actors_from_response)  { response_body_as_json }
      let(:required_actor_attributes) do
        ["id", "name", "date_of_birth", "rate", "votes_count"].sort
      end

      it "returns request not acceptable for invalid format" do
        get actors_path
        expect(response.status).to eql(406)
        expect(response_body_as_json).to match(request_not_acceptable_error)
      end

      it "responds with JSON" do
        get actors_path, format: :json
        expect(response.content_type).to match(/json/)
      end

      it "should have proper structure" do
        get actors_path, format: :json
        expect(actors_from_response).to have_key("actors")
        expect(actors_from_response).to have_key("meta")
        expect(actors_from_response["meta"]).to have_key("count")
        expect(actors_from_response["meta"]["count"]).to eql(2)
        actors_from_response["actors"].each do |actor_from_response|
          expect(actor_from_response.keys.sort).to eql(required_actor_attributes)
        end
      end
    end

    context "when no actors exist" do

      let(:actors_from_response)  { response_body_as_json }

      it "responds with JSON" do
        get actors_path, format: :json
        expect(response.content_type).to match(/json/)
      end

      it "reponds with empty actors list" do
        get actors_path, format: :json
        expect(actors_from_response).to have_key("actors")
        expect(actors_from_response).to have_key("meta")
        expect(actors_from_response["meta"]).to have_key("count")
        expect(actors_from_response["meta"]["count"]).to eql(0)
      end
    end
  end

  describe "GET #show" do
    let(:actor) { create(:actor) }

    let(:actor_from_response)  { response_body_as_json }

    let(:actor_expected_response) do
      build_expected_actor_response(actor: actor)
    end

    it "returns request not acceptable for invalid format" do
      get actor_path(actor.id)
      expect(response.status).to eql(406)
      expect(response_body_as_json).to match(request_not_acceptable_error)
    end

    it "responds with JSON" do
      get actor_path(actor.id), format: :json
      expect(response.content_type).to match(/json/)
    end

    it "retrieves a specific actor with valid data" do
      get actor_path(actor.id), format: :json
      expect(actor_from_response).to eq(actor_expected_response)
    end

    it "responds with error when resource not exists" do
      get actor_path(-1), format: :json
      expect(response.content_type).to match(/json/)
      expect(response_body_as_json).to match(record_not_found_error)
    end

  end


  describe "PUT #update" do
    let(:actor) { create(:actor) }

    it "returns request not acceptable for invalid format" do
      put actor_path(actor.id)
      expect(response.status).to eql(406)
      expect(response_body_as_json).to match(request_not_acceptable_error)
    end

    context "when actor data root is missing" do
      let(:error_from_response)  { response_body_as_json }

      it "returns error 400 bad request" do
        put actor_path(actor.id), format: :json
        expect(response.status).to eql(400)
        expect(error_from_response).to match(bad_request_error("actor"))
      end
    end

    context "when paras are valid " do
      let(:new_name) { Faker::Name.name }
      let(:new_date) { Faker::Date.between(45.years.ago, 7.years.ago).strftime("%Y-%m-%d") }

      let(:actor_update_params) do
        {
          name: new_name,
          date_of_birth: new_date
        }
      end

      let(:actor_expected_response) do
        build_expected_actor_response(actor: actor.reload)
      end

      it "responds with JSON" do
        put actor_path(actor.id), format: :json, actor: actor_update_params
        expect(response.content_type).to match(/json/)
      end

      it "updates actor" do
        put actor_path(actor.id), format: :json, actor: actor_update_params
        expect(response.status).to eq(200)
        expect(response_body_as_json["actor"]["name"]).to eq(new_name)
        expect(response_body_as_json["actor"]["date_of_birth"]).to eq(new_date)
        expect(response_body_as_json).to eq(actor_expected_response)
      end

      it "does not update rate and votes count" do
        before_update_attributes = actor.attributes
        put actor_path(actor.id), format: :json, actor: { rate: "7.7", votes_count: "86" }
        expect(response_body_as_json["actor"]["rate"]).to eq(before_update_attributes["rate"])
        expect(response_body_as_json["actor"]["votes_count"]).to eq(before_update_attributes["votes_count"])
      end
    end


    context "when params are invalid" do

      let(:invalid_update_params) do
        {
          name: nil,
          date_of_birth: nil
        }
      end


      it "should return 422 status and proper error structure" do
        put actor_path(actor.id), format: :json, actor: invalid_update_params

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
        put actor_path(actor.id), format: :json, actor: invalid_update_params
        invalid_field_names = response_body_as_json["errors"].map { |error| error["invalid_field"] }.uniq
        expect(invalid_field_names).to match_array(["name", "date_of_birth"])
      end

    end

  end

  describe "POST #create" do

    it "returns request not acceptable for invalid format" do
      post actors_path
      expect(response.status).to eql(406)
      expect(response_body_as_json).to match(request_not_acceptable_error)
    end

    context "when actor data root is missing" do
      let(:error_from_response)  { response_body_as_json }

      it "returns error 400 bad request" do
        post actors_path, format: :json
        expect(response.status).to eql(400)
        expect(error_from_response).to match(bad_request_error("actor"))
      end
    end

    context "when params are valid" do

      let(:valid_actor_params) { attributes_for(:actor) }
      let(:actor_from_response)  { response_body_as_json["actor"] }

      it "should create valid actor" do
        post actors_path, format: :json, actor: valid_actor_params
        expect(response.status).to eq(201)
        expect(actor_from_response["name"]).to eql(valid_actor_params[:name])
        expect(actor_from_response["date_of_birth"]).to eql(valid_actor_params[:date_of_birth])
        expect(actor_from_response["rate"]).to eql("0.0")
        expect(actor_from_response["votes_count"]).to eql(0)
      end
    end

    context "when params are invalid" do

      let(:invalid_actor_params) do
        {
          name: nil,
          date_of_birth: nil,
        }
      end

      it "should return 422 status and valid error structure" do
        post actors_path, format: :json, actor: invalid_actor_params
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
        post actors_path, format: :json, actor: invalid_actor_params
        invalid_field_names = response_body_as_json["errors"].map { |error| error["invalid_field"] }.uniq
        expect(invalid_field_names).to match_array(["name", "date_of_birth"])
      end

      it "is invalid with year exceeding range" do
        year_exceeding_valid_range =  Time.now.year + 4
        post actors_path, format: :json, actor: invalid_actor_params.merge({year: year_exceeding_valid_range})
        invalid_field_names = response_body_as_json["errors"].map { |error| error["invalid_field"] }.uniq
        expect(invalid_field_names).to match_array(["name", "date_of_birth"])
      end

    end
  end

  describe "POST #rate" do
    let(:actor) { create(:actor) }
    let(:new_vote) { "7.8" }
    let(:invalid_vote) { "16.0" }
    let(:actor_expected_response) do
      build_expected_actor_response(actor: actor.reload)
    end
    let(:actor_with_rate) { create(:actor, rate: "7.5", votes_count: 10) }

    it "returns request not acceptable for invalid format" do
      post rate_actor_path(actor.id), actor: { vote: new_vote }
      expect(response.status).to eql(406)
      expect(response_body_as_json).to match(request_not_acceptable_error)
    end

    it "responds with json" do
      post rate_actor_path(actor.id), format: :json, actor: { vote: new_vote }
      expect(response.content_type).to match(/json/)
    end

    it "returns valid actor" do
      post rate_actor_path(actor.id), format: :json, actor: { vote: new_vote }
      expect(response_body_as_json).to eq(actor_expected_response)
    end

    it "accepts a new vote" do
      post rate_actor_path(actor.id), format: :json, actor: { vote: new_vote }
      expect(response_body_as_json["actor"]["rate"]).to eq("7.8")
    end

    it "calculates new up vote properly" do
      post rate_actor_path(actor_with_rate.id), format: :json, actor: { vote: "8.1" }
      expect(response_body_as_json["actor"]["rate"]).to eq("7.6")
    end

    it "calculates new down vote properly" do
      post rate_actor_path(actor_with_rate.id), format: :json, actor: { vote: "4.1" }
      expect(response_body_as_json["actor"]["rate"]).to eq("7.2")
    end

    context "when actor data root is missing" do
      let(:error_from_response)  { response_body_as_json }

      it "returns error 400 bad request" do
        post rate_actor_path(actor.id), format: :json
        expect(response.status).to eql(400)
        expect(error_from_response).to match(bad_request_error("actor"))
      end
    end

    context "when invalid vote is provided" do

      it "returns errors object with poper structure" do
        post rate_actor_path(actor_with_rate.id), format: :json, actor: { vote: invalid_vote }
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
        post rate_actor_path(actor_with_rate.id), format: :json, actor: { vote: invalid_vote }
        invalid_field_names = response_body_as_json["errors"].map { |error| error["invalid_field"] }.uniq
        expect(invalid_field_names).to match_array(["rate"])
      end
    end
  end

  describe "movie scope" do

    describe "GET #index" do

      context "when some actors exist for movie" do
        let(:actor1) { create(:actor, name: "Yvonne Hodkiewicz", rate: "8.7") }
        let(:actor2) { create(:actor, name: "Jacklyn Brakus", rate: "6.4") }
        let(:actor3) { create(:actor, name: "Hillard Keeling", rate: "5.4") }
        let(:actor4) { create(:actor, name: "Weston Lindgren", rate: "7.6") }
        let(:actor5) { create(:actor, name: "Newell Von", rate: "4.9") }
        let(:actor6) { create(:actor, name: "Eino Goyette", rate: "7.6") }
        let(:actor7) { create(:actor, name: "Antonia Simonis", rate: "4.9") }

        let(:movie) { create(:movie, actors: [actor1, actor2, actor3, actor4, actor5, actor6, actor7]) }

        let(:actors_from_response)  { response_body_as_json }
        let(:required_actor_attributes) do
          ["id", "name", "date_of_birth", "rate", "votes_count"].sort
        end

        let(:expected_ordered_actors_ids_list) do
          [actor1.id, actor6.id, actor4.id, actor2.id, actor3.id, actor7.id, actor5.id]
        end

        let(:actors_ids_from_response) do
          actors_from_response["actors"].map { |actor| actor["id"] }
        end

        it "returns request not acceptable for invalid format" do
          get movie_actors_path(movie.id)
          expect(response.status).to eql(406)
          expect(response_body_as_json).to match(request_not_acceptable_error)
        end

        it "responds with JSON" do
          get movie_actors_path(movie.id), format: :json
          expect(response.content_type).to match(/json/)
        end

        it "rsponse has proper structure" do
          get movie_actors_path(movie.id), format: :json
          expect(actors_from_response).to have_key("actors")
          expect(actors_from_response).to have_key("meta")
          expect(actors_from_response["meta"]).to have_key("count")
          expect(actors_from_response["meta"]["count"]).to eql(7)
          expect(actors_from_response["actors"].size).to eql(7)
          actors_from_response["actors"].each do |actor_from_response|
            expect(actor_from_response.keys.sort).to eql(required_actor_attributes)
          end
        end

        it "actors are sorted by rate and name" do
          get movie_actors_path(movie.id), format: :json
          expect(actors_ids_from_response).to eql(expected_ordered_actors_ids_list)
        end
      end

      context "when no actors exist" do
        let(:movie) { create(:movie) }
        let(:actors_from_response)  { response_body_as_json }

        it "responds with JSON" do
          get movie_actors_path(movie.id), format: :json
          expect(response.content_type).to match(/json/)
        end

        it "reponds with empty actors list" do
          get movie_actors_path(movie.id), format: :json
          expect(actors_from_response).to have_key("actors")
          expect(actors_from_response).to have_key("meta")
          expect(actors_from_response["meta"]).to have_key("count")
          expect(actors_from_response["meta"]["count"]).to eql(0)
        end
      end
    end

    describe "POST #create" do
      let(:movie) { create(:movie) }

      it "returns request not acceptable for invalid format" do
        post movie_actors_path(movie.id)
        expect(response.status).to eql(406)
        expect(response_body_as_json).to match(request_not_acceptable_error)
      end

      context "when actor_id param is missing" do
        let(:error_from_response)  { response_body_as_json }

        it "returns error 400 bad request" do
          post movie_actors_path(movie.id), format: :json
          expect(response.status).to eql(400)
          expect(error_from_response).to match(bad_request_error("actor_id"))
        end
      end

      context "when invalid actor_id is provided" do
        let(:error_from_response)  { response_body_as_json }

        it "returns error 404 record not found" do
          post movie_actors_path(movie.id), format: :json, actor_id: -1
          expect(response.status).to eql(404)
          expect(error_from_response).to match(record_not_found_error)
        end
      end

      context "when valid actor_id is provided" do
        let(:actor) { create(:actor) }
        let(:response_message)  { response_body_as_json }
        let(:expected_response_message) { "Actor #{actor.name} has been added to #{movie.title} cast" }

        it "adds actor to cast" do
          post movie_actors_path(movie.id), format: :json, actor_id: actor.id
          expect(response.status).to eql(201)
          expect(response_message).to have_key("message")
          expect(response_message["message"]).to eql(expected_response_message)
        end
      end
    end




  end

end
