require 'rails_helper'

RSpec.describe 'Session management', type: :request do
  describe 'POST /api/v1/login' do
    it 'logs the user in and returns their profile' do
      user = FactoryBot.create(:user)

      post '/api/v1/login', params: { email: user.email }

      expect(response).to be_successful
      expect(session[:user_id]).to eq(user.id)

      json = JSON.parse(response.body, symbolize_names: true)[:data]
      attributes = json[:attributes]

      expect(json[:id]).to eq(user.id.to_s)
      expect(attributes[:email]).to eq(user.email)
    end

    it 'returns unauthorized when the email is invalid' do
      post '/api/v1/login', params: { email: 'missing@example.com' }

      expect(response).to have_http_status(:unauthorized)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq('Invalid email')
    end
  end
end
