FactoryGirl.define do
  factory :actor do
    name { Faker::Name.name }
    date_of_birth Faker::Date.between(60.years.ago, 19.years.ago).strftime("%Y-%m-%d")
    rate { rand(0.1..10.0).round(1).to_s }
  end
end
