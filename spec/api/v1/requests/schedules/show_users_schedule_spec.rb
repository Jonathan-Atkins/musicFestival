require 'rails_helper'

RSpec.describe 'Get a Users Schedule', type: :request do
  before(:each) do
    @festival = FactoryBot.create(:festival)
    @stage = FactoryBot.create(:stage, festival: @festival)
    @shows = FactoryBot.create_list(:show, 3, stage: @stage)

    @user_with_schedule = FactoryBot.create(:user)
    @schedule = FactoryBot.create(:schedule, user: @user_with_schedule)
    @shows.each do |show|
      FactoryBot.create(:schedule_show, schedule: @schedule, show: show)
    end

    @user_no_schedule = FactoryBot.create(:user)
    @user_empty_schedule = FactoryBot.create(:user)
    @empty_schedule = FactoryBot.create(:schedule, user: @user_empty_schedule)
  end

  describe 'GET /api/v1/users/:id/schedule' do
    context 'happy path' do
      it 'returns the user schedule and associated shows' do
        get "/api/v1/users/#{@user_with_schedule.id}/schedules/#{@schedule.id}"
      
        expect(response).to be_successful
      
        json     = JSON.parse(response.body, symbolize_names: true)
        data     = json[:data]
        shows    = data[:attributes][:shows]
      
        expect(shows.size).to eq(@shows.size)
      
        @shows.each do |show|
          resp = shows.find { |s| s[:id] == show.id }
      
          expect(resp[:artist]).to   eq(show.artist)
          expect(resp[:date]).to     eq(show.date.to_s)
          expect(resp[:location]).to eq(show.location)
          # expect(resp[:time]).to     eq(show.time.to_s)
        end
      end
    end

    context 'sad paths' do
      it 'returns 404 if user does not exist' do
        get "/api/v1/users/0/schedules/0"
    
        expect(response).to have_http_status(404)
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:errors].first[:detail]).to match(/User not found/)
      end
    end
    

    context 'edge cases' do
      it 'returns empty shows array if user schedule exists but has no shows' do
        get "/api/v1/users/#{@user_empty_schedule.id}/schedules/#{@empty_schedule.id}"

        expect(response).to be_successful

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:data][:attributes][:shows]).to eq([])
      end

      it 'returns 404 if user ID is invalid format' do
        get "/api/v1/users/abc/schedule"

        expect(response).to have_http_status(404)
      end
    end
  end
end
