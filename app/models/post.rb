class Post < ActiveRecord::Base
  has_many :post_media
  has_many :images, through: :post_media, source: :medium, source_type: "Image"
  has_many :videos, through: :post_media, source: :medium, source_type: "Video"

  has_many :comments, as: :commentable

  validates :body, :title, presence: true
end
