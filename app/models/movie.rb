class Movie < ActiveRecord::Base
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :actors

  validates :title, :description, presence: true


  def self.valid_years_range
    minimum_year..maximum_year
  end

  def self.minimum_year
    "1900"
  end

  def self.maximum_year
    (Date.today + 3.years).year.to_s
  end

  validates :year,
    presence: true,
    inclusion: { in: valid_years_range, message: "should be in range: #{minimum_year} - #{maximum_year}" }

  validates :runtime,
    presence: true,
    numericality: { greater_than: 0, message: "should be greater than 0" }

  before_validation :set_default_rate, :set_default_votes_count, on: :create

  private

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

  def rate_provided?
    rate.present?
  end

end
