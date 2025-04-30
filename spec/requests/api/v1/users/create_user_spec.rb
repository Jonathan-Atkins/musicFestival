require 'rails_helper'

RSpec.describe 'User Creation', type: :request do
  describe 'POST /api/v1/users' do
    context 'happy path' do
      it 'creates a new user and returns the serialized user data' do
        user_attrs = FactoryBot.attributes_for(:user)

        post '/api/v1/users', params: { user: user_attrs }

        expect(response).to be_successful

        json = JSON.parse(response.body, symbolize_names: true)[:data]
        attrs = json[:attributes]

        expect(attrs[:first_name]).to eq(user_attrs[:first_name])
        expect(attrs[:last_name]).to eq(user_attrs[:last_name])
        expect(attrs[:email]).to eq(user_attrs[:email])
        expect(attrs[:username]).to eq(user_attrs[:username])
        expect(attrs[:birthday]).to eq(user_attrs[:birthday].to_s)
      end
    end

    context 'sad path' do
      it 'returns errors when required fields are missing' do

        post '/api/v1/users', params: { user: { first_name: Faker::Name.first_name } }

        expect(response).to_not be_successful

        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:errors]).to include(
          "Last name can't be blank",
          "Username can't be blank",
          "Birthday can't be blank"
        )
      end

      it 'returns an error if the email is already taken' do
        existing_user = FactoryBot.create(:user, email: 'taken@example.com')
        user_attrs    = FactoryBot.attributes_for(:user, email: 'taken@example.com')

        post '/api/v1/users', params: { user: user_attrs }

        expect(response).to_not be_successful

        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:errors]).to include("Email has already been taken")
      end
    end
  end
end
