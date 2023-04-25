class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password_digest, confirmation: true
  validates_confirmation_of :password_digest
  
end
