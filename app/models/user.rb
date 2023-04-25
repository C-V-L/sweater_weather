class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, confirmation: true
  validates_confirmation_of :password
  validates :api_key, presence: true, uniqueness: true

  before_validation :create_api_key

  def create_api_key
    self.api_key = SecureRandom.hex(13)
  end
end
