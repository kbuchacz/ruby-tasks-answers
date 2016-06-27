module Helpers
  def build_expected_movie_response(movie:)
    {
      "movie" => {
        "id" => movie.id,
        "title" => movie.title,
        "year" => movie.year,
        "runtime" => movie.runtime,
        "description" =>  movie.description,
        "rate" =>  movie.rate,
        "votes_count" => movie.votes_count,
      }
    }
  end

  def build_expected_actor_response(actor:)
    {
      "actor" => {
        "id" => actor.id,
        "name" => actor.name,
        "date_of_birth" => actor.date_of_birth.strftime("%Y-%m-%d"),
        "rate" =>  actor.rate,
        "votes_count" => actor.votes_count,
      }
    }
  end

  def record_not_found_error
    {
      "errors" => [
        "code" => "RECORD_NOT_FOUND",
        "status" => 404,
        "message" => /Record not found/
      ]
    }
  end


  def bad_request_error(message)
    {
      "errors" => [
        "code" => "BAD_REQUEST",
        "status" => 400,
        "message" => /#{message}/
      ]
    }
  end

  def request_not_acceptable_error
    {
      "errors" => [
        "code" => "REQUEST_NOT_ACCEPTABLE",
        "status" => 406,
        "message" => /.*/
      ]
    }
  end

end
