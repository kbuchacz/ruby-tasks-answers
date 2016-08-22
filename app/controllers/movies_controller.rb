class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies, root: "movies", each_serializer: MovieSerializer,
      meta: { count: movies.count }, adapter: :json
  end

  def show
    movie = Movie.find(params[:id])
    render json: movie, root: "movie", serializer: MovieSerializer, adapter: :json

  end

  def create
    movie = Movie.new(create_movie_params)
    if movie.save
      render json: movie, root: "movie", serializer: MovieSerializer, adapter: :json,
        status: :created
    else
      respond_with_errors(movie)
    end
  end

  def update
    movie = Movie.find(params[:id])
    if movie.update_attributes(update_movie_params)
      render json: movie, root: "movie", serializer: MovieSerializer, adapter: :json,
        status: :ok
    else
      respond_with_errors(movie)
    end
  end

  def rate
    movie = Movie.find(params[:id])
    if ("0.1".."10.0").to_a.include?(vote_param)
      rate_movie(movie, vote_param)
      render json: movie, root: "movie", serializer: MovieSerializer, adapter: :json,
        status: :ok
    else
      movie.errors[:rate] << "vote #{vote_param} is not included in the range: 0.1 - 10.0"
      respond_with_errors(movie)
    end
  end


  private

  def create_movie_params
    params.require(:movie).permit(:title, :description, :year, :runtime)
  end

  def update_movie_params
    params.require(:movie).permit(:title, :description, :year, :runtime)
  end

  def vote_param
    params.require(:movie).require(:vote)
  end

  def rate_movie(movie, vote_param)
    current_rate = movie.rate
    current_votes_count = movie.votes_count
    new_vote_value = vote_param.to_f
    new_rate = calculate_new_rate(current_rate, current_votes_count, new_vote_value)
    movie.update_attributes(rate: new_rate, votes_count: current_votes_count + 1)
  end

  def calculate_new_rate(current_rate, votes_count, new_vote)
    new_rate = ((current_rate.to_f * votes_count) + new_vote) / (votes_count + 1)
    new_rate.round(1).to_s
  end
end
