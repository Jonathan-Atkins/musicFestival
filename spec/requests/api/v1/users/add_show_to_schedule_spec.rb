# spec/requests/api/v1/users/add_show_to_schedule_spec.rb
require 'rails_helper'

RSpec.describe 'Add Show to Schedule', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @schedule = FactoryBot.create(:schedule, user: @user)
    @festival = FactoryBot.create(:festival)
    @stage = FactoryBot.create(:stage, festival: @festival)
    @show = FactoryBot.create(:show, stage: @stage)
  end

  describe 'POST /api/v1/users/:user_id/schedules/:schedule_id/shows' do
    context 'happy path' do
      it 'adds the show to the user’s schedule' do

        post "/api/v1/users/#{@user.id}/schedules/#{@schedule.id}/shows", params: { show_id: @show.id }

        expect(response).to be_successful

        message = JSON.parse(response.body, symbolize_names: true)[:message]
        expect(message).to eq("Show successfully added to schedule.")
      end
    end

    context 'sad paths' do
      it 'returns error if show_id is missing' do
        post "/api/v1/users/#{@user.id}/schedules/#{@schedule.id}/shows"

        expect(response).to_not be_successful

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:error]).to eq("Show ID must be provided.")
      end

      it 'returns error if user does not exist' do
        post "/api/v1/users/0/schedules/#{@schedule.id}/shows", params: { show_id: @show.id }

        expect(response).to_not be_successful

        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data[:error]).to eq("User or schedule not found.")
      end

      it 'returns error if schedule does not belong to user' do
        other_user = FactoryBot.create(:user)
        other_schedule = FactoryBot.create(:schedule, user: other_user)

        post "/api/v1/users/#{@user.id}/schedules/#{other_schedule.id}/shows", params: { show_id: @show.id }

        expect(response).to_not be_successful

        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data[:error]).to eq("User or schedule not found.")
      end
    end
  end
end
