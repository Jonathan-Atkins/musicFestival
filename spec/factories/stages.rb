FactoryBot.define do
  factory :stage do
    name { Faker::Internet.unique.username }
    festival { Faker::Cannabis.festival }
  end
end
