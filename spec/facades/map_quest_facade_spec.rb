require 'rails_helper'

describe 'Mapquest Facade' do
  describe '#road_trip' do
    describe 'happy path' do
      it 'returns a road trip object with travel time and arrival forecast' do
        VCR.use_cassette('mapquest_facade_road_trip') do
          payload = { origin: 'Denver,CO', destination: 'Moab,UT' }
          road_trip = MapQuestFacade.new(payload).road_trip
          expect(road_trip).to be_a(Hash)
          expect(road_trip[:start_city]).to eq('Denver,CO')
          expect(road_trip[:end_city]).to eq('Moab,UT')
          expect(road_trip[:travel_time]).to be_a(String)
          expect(road_trip[:travel_time]).to eq("05:16:00")
          expect(road_trip[:weather_at_eta]).to be_a(Hash)
          expect(road_trip[:weather_at_eta].keys).to contain_exactly(:temperature, :conditions, :datetime)
          expect(road_trip[:weather_at_eta][:datetime]).to be_a(String)
          expect(road_trip[:weather_at_eta][:temperature]).to be_a(Float)
          expect(road_trip[:weather_at_eta][:conditions]).to be_a(String)
        end
      end
    end
  end
end