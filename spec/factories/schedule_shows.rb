FactoryBot.define do
  factory :schedule_show do
    association :schedule
    association :show
    title { show.artist }   
    date { show.date } 
  end
end
