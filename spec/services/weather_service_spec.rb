require 'rails_helper'

describe 'Weather Service' do
  describe 'get_forecast_weather' do
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

  describe 'get_timebased_weather' do
    it 'can take a location, date, and hour and return weather data' do
      VCR.use_cassette('moab_future_weather') do
        weather = WeatherService.get_timebased_weather("moab,ut", '2023-04-26', '12')
        expect(weather).to be_a(Hash)
        expect(weather.keys).to eq([:location, :current, :forecast])
        expect(weather[:location][:name]).to eq("Moab")
        expect(weather[:forecast].keys).to eq([:forecastday])
        expect(weather[:forecast][:forecastday].count).to eq(1)
        expect(weather[:forecast][:forecastday][0].keys).to eq([:date, :date_epoch, :day, :astro, :hour])
        expect(weather[:forecast][:forecastday][0][:hour].count).to eq(1)
        expect(weather[:forecast][:forecastday][0][:hour][0].keys).to include(:time, :temp_c, :temp_f, :condition)
      end
    end
  end

end