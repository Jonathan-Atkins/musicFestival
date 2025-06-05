require 'rails_helper'

RSpec.describe FestivalSerializer, :vcr do
  it 'includes name, zip_code, attendee_count, artists, and weather' do
    festival = FactoryBot.create(:festival, zip_code: '90210')
    stage = FactoryBot.create(:stage, festival: festival)
    show = FactoryBot.create(:show, stage: stage, artist: 'Daft Punk')
    user = FactoryBot.create(:user)
    schedule = FactoryBot.create(:schedule, user: user)
    FactoryBot.create(:schedule_show, schedule: schedule, show: show)

    serialized = FestivalSerializer.new(festival).serializable_hash
    attributes = serialized[:data][:attributes]

    expect(attributes).to include(
      name: festival.name,
      zip_code: '90210',
      attendee_count: 1,
      artists: ['Daft Punk']
    )

    expect(attributes[:weather]).to be_a(Hash)
    expect(attributes[:weather]).to have_key(:day_outlook)
    expect(attributes[:weather]).to have_key(:temperature)
  end
end
