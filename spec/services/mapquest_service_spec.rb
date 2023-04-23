require  'rails_helper'

describe 'Mapquest Service' do
  describe 'happy path' do
    it 'can take a location and return latitude and longitude' do
      VCR.use_cassette('mapquest_denver') do
       location = MapquestService.get_coordinates('denver,co')

        location_details = location[:results]
        expect(location).to be_a(Hash)
        expect(location_details).to be_an(Array)
        expect(location_details[0]).to be_a(Hash)
        expect(location_details[0][:locations]).to be_an(Array)
        expect(location_details[0][:locations][0]).to be_a(Hash)
        expect(location_details[0][:locations][0]).to have_key(:latLng)
        expect(location_details[0][:locations][0][:latLng]).to eq({:lat=>39.74001, :lng=>-104.99202})
      end
    end
  end
end