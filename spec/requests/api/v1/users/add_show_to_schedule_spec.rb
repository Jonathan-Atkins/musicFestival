# spec/requests/api/v1/users/add_show_to_schedule_spec.rb
require 'rails_helper'

RSpec.describe 'Add Show to Schedule', type: :request do
  before(:each) do
    @user     = FactoryBot.create(:user)
    @schedule = FactoryBot.create(:schedule, user: @user)
    @festival = FactoryBot.create(:festival)
    @stage    = FactoryBot.create(:stage, festival: @festival)
    @show     = FactoryBot.create(:show, stage: @stage)
  end

  describe 'POST /api/v1/users/:user_id/schedules/:schedule_id/shows' do
    context 'happy path' do
      it 'adds the show to the user’s schedule' do
        post "/api/v1/users/#{@user.id}/schedules/#{@schedule.id}/shows", params: { show_id: @show.id }

        # UPDATED: assert explicit status code (controller returns :created)
        expect(response.status).to eq(201)

        message = JSON.parse(response.body, symbolize_names: true)[:message]
        expect(message).to eq("Show added to schedule successfully.")
      end
    end

    context 'sad paths' do
      it 'returns 400 if show_id is missing' do
        post "/api/v1/users/#{@user.id}/schedules/#{@schedule.id}/shows"

        # UPDATED: be explicit about status (bad request)
        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)
        # UPDATED: message text matched to controller ("Show ID must be provided" — no period)
        expect(data[:error]).to eq("Show ID must be provided")
      end

      it 'returns 404 if user does not exist' do
        post "/api/v1/users/0/schedules/#{@schedule.id}/shows", params: { show_id: @show.id }

        # UPDATED: explicit 404
        expect(response.status).to eq(404)

        data = JSON.parse(response.body, symbolize_names: true)
        # UPDATED: message text matched to controller ("User not found" — no period)
        expect(data[:error]).to eq("User not found")
      end

      it 'returns 404 if schedule does not belong to user' do
        other_user     = FactoryBot.create(:user)
        other_schedule = FactoryBot.create(:schedule, user: other_user)

        post "/api/v1/users/#{@user.id}/schedules/#{other_schedule.id}/shows", params: { show_id: @show.id }

        # UPDATED: explicit 404
        expect(response.status).to eq(404)

        data = JSON.parse(response.body, symbolize_names: true)
        # UPDATED: message text matched to controller
        expect(data[:error]).to eq("Schedule not found for this user")
      end

      it 'returns 404 if show is not found' do
        # NEW: invalid show id path
        post "/api/v1/users/#{@user.id}/schedules/#{@schedule.id}/shows", params: { show_id: 0 }

        expect(response.status).to eq(404)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:error]).to eq("Show not found")
      end

      it 'returns 422 if the show is already in the schedule' do
        # NEW: first add succeeds
        post "/api/v1/users/#{@user.id}/schedules/#{@schedule.id}/shows", params: { show_id: @show.id }
        expect(response.status).to eq(201)

        # NEW: second add should fail due to app-level check (and model/DB uniqueness once added)
        post "/api/v1/users/#{@user.id}/schedules/#{@schedule.id}/shows", params: { show_id: @show.id }
        expect(response.status).to eq(422)

        data = JSON.parse(response.body, symbolize_names: true)
        # NOTE: controller message includes a period here — keep exact match
        expect(data[:error]).to eq("Show already exists in schedule.")
      end
    end
  end
end
