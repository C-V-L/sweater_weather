require 'rails_helper'

describe 'Teleport Facade' do
  describe 'happy path' do
    it 'can take a city and return salary and weather data' do
      VCR.use_cassette('denver_weather_and_salary') do
        hash = TeleportFacade.new('denver').get_salary_and_weather_data
        expect(hash).to be_a(Hash)
        expect(hash.keys).to eq([:weather, :salary_data])
        expect(hash[:weather]).to be_a(Hash)
        expect(hash[:weather].keys).to eq([:location, :current])
        expect(hash[:salary_data]).to be_a(Hash)
        expect(hash[:salary_data]).to have_key(:salaries)
        expect(hash[:salary_data][:salaries]).to be_an(Array)
        expect(hash[:salary_data][:salaries][0].keys).to eq([:job, :salary_percentiles])
      end
    end
  end

  describe 'sad path' do
    it 'will return an error if the city is not found' do
      VCR.use_cassette('invalid_city') do
        error = TeleportFacade.new('asdf').get_salary_and_weather_data
        expect(error).to be_a(Hash)
        expect(error.keys).to eq([:error])
        expect(error[:error]).to eq('City not found')
      end
    end
  end
end