FactoryBot.define do
  factory :stage do
    name { Faker::Internet.unique.username }
    festival { create(:festival) }  
  end
end
