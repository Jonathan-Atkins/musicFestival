FactoryBot.define do
  factory :schedule do
    title { Faker::Lorem.sentence(word_count: 3) }
    association :user
  end
end
