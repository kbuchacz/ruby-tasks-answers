class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :year, :runtime, :rate, :votes_count
end
