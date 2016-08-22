module Movies
  class ActorsController < ApplicationController
    before_filter :find_movie

    def index
      actors = @movie.actors.order("rate DESC, name ASC")
      render json: actors, root: "actors", each_serializer: ActorSerializer,
        meta: { count: actors.count }, adapter: :json
    end

    def create
      actor = Actor.find(associate_actor_params)
      @movie.actors << actor
      render json: { message: "Actor #{actor.name} has been added to #{@movie.title} cast"},
        adapter: :json, status: :created
    end

    def find_movie
      @movie = Movie.find(params[:movie_id])
    end

    private


    def associate_actor_params
      params.require(:actor_id)
    end
  end
end
