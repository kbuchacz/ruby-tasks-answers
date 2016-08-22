class ActorsController < ApplicationController

  def index
    actors = Actor.all
    render json: actors, root: "actors", each_serializer: ActorSerializer,
      meta: { count: actors.count }, adapter: :json
  end

  def show
    actor = Actor.find(params[:id])
    render json: actor, root: "actor", serializer: ActorSerializer,
      adapter: :json
  end

  def create
    actor = Actor.new(create_actor_params)
    if actor.save
      render json: actor, root: "actor", serializer: ActorSerializer, adapter: :json,
        status: :created
    else
      respond_with_errors(actor)
    end
  end

  def update
    actor = Actor.find(params[:id])
    if actor.update_attributes(update_actor_params)
      render json: actor, root: "actor", serializer: ActorSerializer, adapter: :json,
        status: :ok
    else
      respond_with_errors(actor)
    end
  end

  def rate
    actor = Actor.find(params[:id])
    if ("0.1".."10.0").to_a.include?(vote_param)
      rate_actor(actor, vote_param)
      render json: actor, root: "actor", serializer: ActorSerializer, adapter: :json,
        status: :ok
    else
      actor.errors[:rate] << "vote #{vote_param} is not included in the range: 0.1 - 10.0"
      respond_with_errors(actor)
    end
  end


  private

  def create_actor_params
    params.require(:actor).permit(:name, :date_of_birth)
  end

  def update_actor_params
    params.require(:actor).permit(:name, :date_of_birth)
  end


  def vote_param
    params.require(:actor).require(:vote)
  end

  def rate_actor(actor, vote_param)
    current_rate = actor.rate
    current_votes_count = actor.votes_count
    new_vote_value = vote_param.to_f
    new_rate = calculate_new_rate(current_rate, current_votes_count, new_vote_value)
    actor.update_attributes(rate: new_rate, votes_count: current_votes_count + 1)
  end

  def calculate_new_rate(current_rate, votes_count, new_vote)
    new_rate = ((current_rate.to_f * votes_count) + new_vote) / (votes_count + 1)
    new_rate.round(1).to_s
  end


end
