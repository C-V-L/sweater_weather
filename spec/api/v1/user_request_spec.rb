require 'rails_helper'

describe 'User API' do
  describe 'create user' do
    before :each do
      User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password')
    end
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
        expect(user[:data][:attributes][:api_key]).to be_a(String)
        expect(user[:data][:attributes]).to have_key(:email)
        expect(user[:data][:attributes][:email]).to eq(user_params[:email])
        expect(user[:data][:attributes]).to_not have_key(:password)
      end
    end

    describe 'sad path' do
      it 'returns an error if email is already taken' do
        user2_params = {
          email: 'test@test.com', 
          password: 'password',
          password_confirmation: 'password' 
        }
        post '/api/v1/users', params: user2_params

        error = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(404)
        expect(error[:errors][0][:title]).to eq("Validation failed: Email has already been taken")
      end

      it 'returns an error if password and password confirmation do not match' do
        user_params = {
          email: 'test1@test.com', 
          password: 'password1',
          password_confirmation: 'password' 
        }
        post '/api/v1/users', params: user_params

        error = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(404)
        expect(error[:errors][0][:title]).to include("Validation failed: Password confirmation doesn't match Password")
      end
    end
  end
end