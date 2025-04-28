FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.unique.email }
    birthday   { Faker::Date.birthday(min_age: 18, max_age: 65) }
    username   { Faker::Internet.unique.username }
  end
end
