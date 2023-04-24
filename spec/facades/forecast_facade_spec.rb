require 'rails_helper'

describe 'Forecase Facade' do
  it 'can take a city/state location and return GPS weather data' do
    VCR.use_cassette('weather_denver') do
      VCR.use_cassette('get_denver_weather') do
        weather = ForecastFacade.new('denver,co').get_current_weather
        expect(weather).to be_a(Hash)
        expect(weather).to have_key(:location)
        expect(weather[:location]).to be_a(Hash)
        expect(weather[:location]).to have_key(:lat)
        expect(weather[:location]).to have_key(:lon)
        expect(weather).to have_key(:current)
        expect(weather[:current]).to be_a(Hash)
        expect(weather[:current]).to have_key(:temp_f)
        expect(weather[:current][:condition]).to be_a(Hash)
        expect(weather[:current][:condition]).to have_key(:text)
        expect(weather).to have_key(:forecast)
        expect(weather[:forecast]).to be_a(Hash)
        expect(weather[:forecast]).to have_key(:forecastday)
        expect(weather[:forecast][:forecastday].count).to eq(5)
      end
    end
  end
end