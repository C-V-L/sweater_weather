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
          expect(json).to have_key(:data)
          expect(json[:data].keys).to eq([:id, :type, :attributes])
          expect(json[:data][:id]).to eq(nil)
          expect(json[:data][:type]).to eq('salaries')
          expect(json[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
          expect(json[:data][:attributes][:destination]).to eq('Denver')
          expect(json[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
          expect(json[:data][:attributes][:forecast][:summary]).to be_a(String)
          expect(json[:data][:attributes][:forecast][:temperature]).to be_a(String)
          expect(json[:data][:attributes][:salaries]).to be_an(Array)
          expect(json[:data][:attributes][:salaries][0].keys).to eq([:title, :min, :max])
          titles = json[:data][:attributes][:salaries].map do |job|
            job[:title]
          end
          expect(titles).to eq(["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"])
        end
      end
    end
  end
end