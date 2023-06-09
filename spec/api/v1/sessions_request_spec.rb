require 'rails_helper'

describe 'Sessions API' do
  describe 'create session' do
    before :each do
      User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password')
    end
    describe 'happy path' do
      it 'finds a user and creates a session' do
        user_params = { 
          email: 'test@test.com',
          password: 'password'
        }
        post '/api/v1/sessions', params: user_params.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to be_successful
        login = JSON.parse(response.body, symbolize_names: true)
        expect(login).to have_key(:data)
        expect(login[:data]).to have_key(:type)
        expect(login[:data][:type]).to eq('users')
        expect(login[:data]).to have_key(:id)
        expect(login[:data][:attributes]).to have_key(:email)
        expect(login[:data][:attributes]).to have_key(:api_key)
        expect(login[:data][:attributes][:email]).to eq(user_params[:email])
      end
    end

    describe 'sad path' do
      it 'returns a non-specfic error if email is not found' do
        user_params = {
          email: 'test1@test.com',
          password: 'password'
        }
        post '/api/v1/sessions', params: user_params.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        error = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(401)
        expect(error[:error]).to eq("Email or password is incorrect")
      end

      it 'returns a non-specfic error if password is not correct' do
        user_params = {
          email: 'test@test.com',
          password: 'password1'
        }
        post '/api/v1/sessions', params: user_params.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        error = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(401)
        expect(error[:error]).to eq("Email or password is incorrect")
      end
    end
  end
end