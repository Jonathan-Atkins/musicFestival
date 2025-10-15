require 'rails_helper'

RSpec.describe 'Find User by Email', type: :request do
  describe 'GET /api/v1/users/find?email=' do
    context 'when the user exists' do
      let!(:user) { FactoryBot.create(:user, email: 'test@example.com') }

      it 'returns the user with status 200' do
        get '/api/v1/users/find', params: { email: 'test@example.com' }

        expect(response).to be_successful

        json = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(json[:id]).to eq(user.id.to_s)
        expect(json[:type]).to eq('user')

        attributes = json[:attributes]
        expect(attributes[:email]).to eq(user.email)
        expect(attributes[:first_name]).to eq(user.first_name)
        expect(attributes[:last_name]).to eq(user.last_name)
        expect(attributes[:username]).to eq(user.username)
        expect(attributes[:birthday]).to eq(user.birthday.to_s)
      end
    end

    context 'when the user does not exist' do
      it 'returns a 404 with an error message' do
        get '/api/v1/users/find', params: { email: 'notfound@example.com' }

        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:error]).to eq('User not found')
      end
    end
  end
end
