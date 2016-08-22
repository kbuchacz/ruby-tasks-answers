class ActorSerializer < ActiveModel::Serializer
  attributes :id, :name, :date_of_birth, :rate, :votes_count
end
