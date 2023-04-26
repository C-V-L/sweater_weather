require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_confirmation_of(:password)}


  describe 'instance methods' do
    describe '#generate_api_key' do
      it 'generates a unique hexidecimal api key upon user creation' do
        user = User.create!(email: 'test.com', password: 'password', password_confirmation: 'password')
        expect(user.api_key).to be_a(String)
        expect(user.api_key.length).to eq(26)
      end
    end
  end
end
