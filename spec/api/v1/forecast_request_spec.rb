require "rails_helper"

describe 'Forecast' do
  describe 'index' do
    describe 'happy path' do
      it 'can take a location and return a formatted 5 day forecast' do
        VCR.use_cassette('get_denver_forecast') do
          get '/api/v1/forecast?location=denver,co'
          expect(response).to be_successful
          forecast = JSON.parse(response.body, symbolize_names: true)
          expect(forecast).to be_a(Hash)
          expect(forecast).to have_key(:data)
          expect(forecast[:data]).to be_a(Hash)
          expect(forecast[:data]).to have_key(:id)
          expect(forecast[:data][:id]).to eq(nil)
          expect(forecast[:data]).to have_key(:type)
          expect(forecast[:data][:type]).to eq('forecast')
          expect(forecast[:data]).to have_key(:attributes)
          expect(forecast[:data][:attributes]).to be_a(Hash)
          expect(forecast[:data][:attributes]).to have_key(:current_weather)
          expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
          expect(forecast[:data][:attributes][:current_weather]).to have_key(:last_updated)
          expect(forecast[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
          expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
          expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
          expect(forecast[:data][:attributes][:current_weather]).to have_key(:feels_like)
          expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
          expect(forecast[:data][:attributes][:current_weather]).to have_key(:humidity)
          expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
          expect(forecast[:data][:attributes][:current_weather]).to have_key(:uvi)
          expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
          expect(forecast[:data][:attributes][:current_weather]).to have_key(:visibility)
          expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_a(Numeric)
          expect(forecast[:data][:attributes][:current_weather]).to have_key(:conditions)
          expect(forecast[:data][:attributes][:current_weather][:conditions]).to be_a(String)
          expect(forecast[:data][:attributes][:current_weather]).to have_key(:icon)
          expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a(String)
          expect(forecast[:data][:attributes]).to have_key(:daily_weather)
          expect(forecast[:data][:attributes][:daily_weather]).to be_a(Array)
          expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)
          expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:date)
          expect(forecast[:data][:attributes][:daily_weather].first[:date]).to be_a(String)
          expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:sunrise)
          expect(forecast[:data][:attributes][:daily_weather].first[:sunrise]).to be_a(String)
          expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:sunset)
          expect(forecast[:data][:attributes][:daily_weather].first[:sunset]).to be_a(String)
          expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:max_temp)
          expect(forecast[:data][:attributes][:daily_weather].first[:max_temp]).to be_a(Float)
          expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:min_temp)
          expect(forecast[:data][:attributes][:daily_weather].first[:min_temp]).to be_a(Float)
          expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:conditions)
          expect(forecast[:data][:attributes][:daily_weather].first[:conditions]).to be_a(String)
          expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:icon)
          expect(forecast[:data][:attributes][:daily_weather].first[:icon]).to be_a(String)
          expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
          expect(forecast[:data][:attributes][:hourly_weather]).to be_a(Array)
          expect(forecast[:data][:attributes][:hourly_weather].count).to eq(24)
          expect(forecast[:data][:attributes][:hourly_weather].first).to have_key(:time)
          expect(forecast[:data][:attributes][:hourly_weather].first[:time]).to be_a(String)
          expect(forecast[:data][:attributes][:hourly_weather].first).to have_key(:temperature)
          expect(forecast[:data][:attributes][:hourly_weather].first[:temperature]).to be_a(Float)
          expect(forecast[:data][:attributes][:hourly_weather].first).to have_key(:conditions)
          expect(forecast[:data][:attributes][:hourly_weather].first[:conditions]).to be_a(String)
        end
      end
    end
  end
end