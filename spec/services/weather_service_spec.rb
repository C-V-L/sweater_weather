require 'rails_helper'

describe 'Weather Service' do
  it 'can take a location and return weather data' do
    VCR.use_cassette('weather_denver') do
      weather = WeatherService.get_forecast_weather(39.74001, -104.99202)
      expect(weather).to be_a(Hash)
      expect(weather).to have_key(:location)
      expect(weather[:location]).to be_a(Hash)
      expect(weather[:location]).to have_key(:name)
      expect(weather[:location][:lat]).to eq(39.74)
      expect(weather[:location][:lon]).to eq(-104.99)
      expect(weather[:current]).to be_a(Hash)
      expect(weather[:current]).to have_key(:temp_f)
      expect(weather[:current][:condition]).to be_a(Hash)
    end
  end
end