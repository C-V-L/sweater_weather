require 'rails_helper'

describe 'Weather Service' do
  it 'can take a location and return weather data' do
    VCR.use_cassette('weather_denver') do
      weather = WeatherService.get_weather(39.74001, -104.99202)
      expect(weather).to be_a(Hash)
    end
  end
end