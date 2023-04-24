require 'rails_helper'

describe 'Salaries API' do
  describe 'index' do
    describe 'happy path' do
      it 'can take a city parameter and return formatted salary and weather data' do
        VCR.use_cassette('request_denver_weather_and_salary') do
          get '/api/v1/salaries?destination=denver'

          expect(response).to be_successful
          json = JSON.parse(response.body, symbolize_names: true)

          expect(json).to be_a(Hash)
          require 'pry'; binding.pry
        end
      end
    end
  end
end