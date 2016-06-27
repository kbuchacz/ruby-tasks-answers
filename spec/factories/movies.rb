FactoryGirl.define do
  factory :movie do
    title { Faker::Book.title }
    runtime { 80 + rand(40) }
    year { rand(1955..2016).to_s }
    description Faker::Lorem.sentence(5)

    trait :rated do
      rate { ("0.1".."10.0").to_a.sample }
      votes_count { rand(100) + 1 }
    end

    factory :movie_with_genres do

      transient do
        genres_count 5
      end

      after(:create) do |movie, evaluator|
        create_list(:genre, evaluator.genres_count, movies: [movie])
      end
    end

    factory :rated_movie, traits: [:rated]
  end
end
