require 'rails_helper'

describe 'Teleport Service' do
  describe 'happy path' do
    it 'can take a location and return salary data by job' do
      VCR.use_cassette('teleport_denver') do
        salary_data = TeleportService.get_salary_data('denver')
        expect(salary_data).to be_a(Hash)
        expect(salary_data).to have_key(:salaries)
        expect(salary_data[:salaries]).to be_an(Array)
        expect(salary_data[:salaries][0]).to be_a(Hash)
        expect(salary_data[:salaries][0]).to have_key(:job)
        expect(salary_data[:salaries][0][:job].keys).to eq([:id, :title])
        expect(salary_data[:salaries][0]).to have_key(:salary_percentiles)
        expect(salary_data[:salaries][0][:salary_percentiles]).to be_a(Hash)
        expect(salary_data[:salaries][0][:salary_percentiles]).to have_key(:percentile_25)
        expect(salary_data[:salaries][0][:salary_percentiles][:percentile_25]).to be_a(Float)
      end
    end
  end

  describe 'sad path' do
    it 'will return anrror if the city is not found' do
      VCR.use_cassette('teleport_invalid_city') do
        error = TeleportService.get_salary_data('asdf')
        expect(error[:status]).to eq(404)
      end
    end
  end
end