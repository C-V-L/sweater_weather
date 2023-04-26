require 'rails_helper'
require 'timecop'

describe 'Road Trip API' do
  describe '#create' do
    before :each do
      User.create!(email: 'test.com', password: 'password', password_confirmation: 'password')
      Timecop.freeze(Time.new(2023, 4, 25, 18, 0, 0)) # Freeze time to April 25, 2023 6pm
    end

    describe 'happy path' do
      it 'returns a road trip object with travel time and arrival forecast' do
        VCR.use_cassette('road_trip_request') do
          payload = { origin: 'Denver,CO', destination: 'Moab,UT', api_key: User.last.api_key }
          post '/api/v1/road_trip', params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
          expect(response).to be_successful
          road_trip = JSON.parse(response.body, symbolize_names: true)
          expect(road_trip).to be_a(Hash)
          expect(road_trip[:data][:attributes][:start_city]).to eq('Denver,CO')
          expect(road_trip[:data][:attributes][:end_city]).to eq('Moab,UT')
          expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
          expect(road_trip[:data][:attributes][:travel_time]).to eq("05:16:00")
          expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
          expect(road_trip[:data][:attributes][:weather_at_eta].keys).to contain_exactly(:temperature, :conditions, :datetime)
          expect(road_trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
          expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
          expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
          expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to eq("Clear")
          expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to eq(50.7)
          expect(road_trip[:data][:attributes][:weather_at_eta][:datetime]).to eq("2023-04-25 23:31:58")
        end
      end

      it 'can handle a trip that is impossible' do
        VCR.use_cassette('uk_road_trip_request') do
          payload = { origin: 'Denver,CO', destination: 'London,UK', api_key: User.last.api_key }
          post '/api/v1/road_trip', params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
          mission_impossible = (JSON.parse(response.body, symbolize_names: true))
          expect(mission_impossible[:data][:attributes][:travel_time]).to eq("Impossible route")
        end
      end
    end

    describe 'sad path' do
      it 'returns an error if the api key is not valid' do
        VCR.use_cassette('bad_api_request') do
          payload = { origin: 'Denver,CO', destination: 'Moab,UT', api_key: '' }
          post '/api/v1/road_trip', params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
          error = JSON.parse(response.body, symbolize_names: true)
          expect(error[:error]).to eq('Unauthorized')
        end
      end
    end
  end
end