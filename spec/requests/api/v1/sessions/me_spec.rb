require 'rails_helper'

RSpec.describe 'Current session', type: :request do
  describe 'GET /api/v1/me' do
    it 'returns the current user when the session is valid' do
      user = FactoryBot.create(:user)

      # Simulate login via existing endpoint
      get '/api/v1/users/find', params: { email: user.email }
      expect(session[:user_id]).to eq(user.id)

      get '/api/v1/me'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)[:data]
      attributes = json[:attributes]

      expect(json[:id]).to eq(user.id.to_s)
      expect(attributes[:email]).to eq(user.email)
    end

    it 'returns unauthorized when there is no active session' do
      get '/api/v1/me'

      expect(response).to have_http_status(:unauthorized)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq('Not authenticated')
    end
  end
end
