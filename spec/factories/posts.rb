FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body Faker::Lorem.sentence
  end
end
