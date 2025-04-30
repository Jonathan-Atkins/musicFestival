require 'rails_helper'

RSpec.describe 'Remove Show from Schedule', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @schedule = FactoryBot.create(:schedule, user: @user)
    @shows = FactoryBot.create_list(:show, 3)
    @shows.each do |show|
      FactoryBot.create(:schedule_show, schedule: @schedule, show: show)
    end
  end

  describe 'DELETE /api/v1/users/:user_id/schedules/:schedule_id/shows/:show_id' do
    context 'happy path' do
      it 'removes the show from the schedule' do
        expect(@schedule.shows.count).to eq(3)

        delete "/api/v1/users/#{@user.id}/schedules/#{@schedule.id}/shows/#{@shows.first.id}"

        expect(response).to be_successful
        
        @schedule.reload
        
        expect(@schedule.shows.count).to eq(2)
      end
    end

    context 'sad path' do
      it 'returns 404 if the schedule does not exist' do
        delete "/api/v1/users/#{@user.id}/schedules/0/shows/#{@shows.first.id}"
    
        expect(response.status).to eq(404)
        
        body = JSON.parse(response.body, symbolize_names: true)
        
        expect(body[:errors].first[:detail]).to eq("Schedule not found")
      end
    
      it 'returns 404 if the show does not exist in the schedule' do
        invalid_show_id = 999
        delete "/api/v1/users/#{@user.id}/schedules/#{@schedule.id}/shows/#{invalid_show_id}"
    
        expect(response.status).to eq(404)
        
        body = JSON.parse(response.body, symbolize_names: true)
        
        expect(body[:errors].first[:detail]).to eq("Show not found in the schedule")
      end
    
      it 'returns 404 if the user tries to delete a show from an empty schedule' do
        @schedule.shows.clear
        @schedule.reload
    
        delete "/api/v1/users/#{@user.id}/schedules/#{@schedule.id}/shows/#{@shows.first.id}"
    
        expect(response.status).to eq(404)
        
        body = JSON.parse(response.body, symbolize_names: true)
        
        expect(body[:errors].first[:detail]).to eq("Show not found in the schedule")
      end
    end
  end
end
