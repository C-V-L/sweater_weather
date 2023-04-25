require 'rails_helper'

describe 'User API' do
  describe 'create user' do
    describe 'happy path' do
      it 'creates a user and returns an api key' do
        user_params = {
          email: 'bob@bob.bob', 
          password: 'password',
          password_confirmation: 'password' 
        }

        post '/api/v1/users', params: user_params

        expect(response).to be_successful
        user = JSON.parse(response.body, symbolize_names: true)
        expect(user[:data][:attributes]).to have_key(:api_key)
      end
    end
  end
end