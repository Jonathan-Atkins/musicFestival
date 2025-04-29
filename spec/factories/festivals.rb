FactoryBot.define do
  factory :festival do
    name { Faker::Name.unique.name }
  end
end
