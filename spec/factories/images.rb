FactoryGirl.define do
  factory :image do
    sequence(:name) { |n| "Image #{n}" }
    sequence(:url) { |n| "http://images.com/original#{n}.jpeg" }
    description Faker::Lorem.sentence
  end
end
