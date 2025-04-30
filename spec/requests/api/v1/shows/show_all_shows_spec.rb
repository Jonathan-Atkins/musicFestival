# spec/requests/shows/show_all_shows_spec.rb
require 'rails_helper'

RSpec.describe 'List All Shows for a Festival', type: :request do
  before(:each) do
    @festival = FactoryBot.create(:festival)
    @stages   = FactoryBot.create_list(:stage, 2, festival: @festival)
    @shows    = @stages.flat_map do |stage|
      FactoryBot.create_list(:show, 2, stage: stage)
    end
  end

  describe 'GET /api/v1/festivals/:festival_id/shows' do
    context 'happy path' do
      it 'returns all shows associated with the festival' do
        get "/api/v1/festivals/#{@festival.id}/shows"

        expect(response).to be_successful

        shows = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(shows.count).to eq(4)

        show = shows.first[:attributes]
        expect(show).to have_key(:artist)
        expect(show).to have_key(:location)
        expect(show).to have_key(:date)
        expect(show).to have_key(:time)
      end
    end

    context 'sad path' do
      it 'returns 404 if the festival is not found' do
        get "/api/v1/festivals/0/shows"

        expect(response).to_not be_successful

        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:error]).to eq("Festival or schedule not found.")
      end
    end
  end
end
