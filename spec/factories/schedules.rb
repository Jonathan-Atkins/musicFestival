FactoryBot.define do
  factory :schedule do
    title { Faker::Lorem.sentence(word_count: 3) }
    date { Faker::Date.forward(days: 30) }
    association :user
  end
end
