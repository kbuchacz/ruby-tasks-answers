class Video < ActiveRecord::Base
  has_one :post_medium, as: :medium
  has_one :post, through: :post_medium

  has_many :comments, as: :commentable
end
