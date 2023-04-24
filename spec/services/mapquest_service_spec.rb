require  'rails_helper'

describe 'Mapquest Service' do
  describe 'happy path' do
    it 'can take a location and return latitude and longitude' do
      VCR.use_cassette('mapquest_denver') do
        lat_long = MapquestService.get_coordinates('denver,co')
        expect(lat_long).to be_a(Hash)
        expect(lat_long).to have_key(:lat)
        expect(lat_long[:lat]).to be_a(Float)
        expect(lat_long).to have_key(:lng)
        expect(lat_long[:lng]).to be_a(Float)
        # Debating what I want response to look like. Possible more data could be useful, but as of now I'm only using lat and long.
        # expect(location_details).to be_an(Array)
        # expect(location_details[0]).to be_a(Hash)
        # expect(location_details[0][:locations]).to be_an(Array)
        # expect(location_details[0][:locations][0]).to be_a(Hash)
        # expect(location_details[0][:locations][0]).to have_key(:latLng)
        # expect(location_details[0][:locations][0][:latLng]).to eq({:lat=>39.74001, :lng=>-104.99202})
      end
    end
  end
end