FactoryGirl.define do
  factory :video do
    sequence(:name) { |n| "Video #{n}" }
    sequence(:url) { |n| "http://videos.com/original#{n}.mp4" }
    description Faker::Lorem.sentence
  end
end
