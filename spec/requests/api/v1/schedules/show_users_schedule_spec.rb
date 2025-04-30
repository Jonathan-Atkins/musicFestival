require 'rails_helper'

RSpec.describe 'Get a Users Schedule', type: :request do
  before(:each) do
    @festival = FactoryBot.create(:festival)
    @stage    = FactoryBot.create(:stage, festival: @festival)
    @shows    = FactoryBot.create_list(:show, 3, stage: @stage)

    # user with shows
    @user_with_schedule = FactoryBot.create(:user)
    @schedule           = FactoryBot.create(:schedule, user: @user_with_schedule)
    @shows.each do |show|
      FactoryBot.create(:schedule_show, schedule: @schedule, show: show)
    end

    # user with empty schedule
    @user_empty_schedule = FactoryBot.create(:user)
    @empty_schedule      = FactoryBot.create(:schedule, user: @user_empty_schedule)
  end

  describe 'GET /api/v1/users/:user_id/schedules/:id' do
    context 'happy path' do
      it 'returns the user schedule and associated shows' do
        get "/api/v1/users/#{@user_with_schedule.id}/schedules/#{@schedule.id}"

        expect(response).to be_successful

        data  = JSON.parse(response.body, symbolize_names: true)[:data]
        shows = data[:attributes][:shows]

        expect(shows.size).to eq(@shows.size)
        @shows.each do |show|
          resp = shows.find { |s| s[:id] == show.id }
          expect(resp[:artist]).to   eq(show.artist)
          expect(resp[:date]).to     eq(show.date.to_s)
          expect(resp[:location]).to eq(show.location)
        end
      end
    end

    context 'sad path' do
      it 'returns 404 if user does not exist' do
        get "/api/v1/users/0/schedules/0"

        expect(response).to_not be_successful

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:errors].first[:detail]).to match(/User not found/)
      end
    end

    context 'edge cases' do
      it 'returns the empty-schedule message when user has no shows' do
        get "/api/v1/users/#{@user_empty_schedule.id}/schedules/#{@empty_schedule.id}"

        expect(response).to be_successful

        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data[:attributes][:shows]).to eq("You dont have any shows scheduled!")
      end

      it 'returns unsuccessful response when the user ID format is invalid' do
        get "/api/v1/users/abc/schedules/0"

        expect(response).to_not be_successful
      end
    end
  end
end
