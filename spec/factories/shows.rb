FactoryBot.define do
  factory :show do
    artist { Faker::Music.band } 
    location { Faker::Address.city } 
    date { Faker::Date.forward(days: 30) } 
    time { Faker::Time.forward(days: 30, period: :all) } 
  end
end
