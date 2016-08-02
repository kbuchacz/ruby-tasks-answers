class PostMedium < ActiveRecord::Base
  belongs_to :post
  belongs_to :medium, polymorphic: true
end