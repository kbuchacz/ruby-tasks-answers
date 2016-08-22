class Actor < ActiveRecord::Base
  has_and_belongs_to_many :movies
  validates :name, presence: true
  validates :date_of_birth,
    presence: true,
    format: { with: /\A\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])\Z/ }

  validates :votes_count,
    presence: true,
    numericality: { greater_than_or_equal_to: 0 }

  validates :rate,
    presence: true,
    inclusion: { in: ("0.0".."10.0"), message: "should be in range from 0.0 to 10.0" }


  before_validation :set_default_rate, :set_default_votes_count, on: :create

  def set_default_rate
    if rate.blank?
      self.rate = "0.0"
    end
  end

  def set_default_votes_count
    if votes_count.blank?
      self.votes_count = 0
    end
  end
end
