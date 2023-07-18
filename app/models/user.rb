class User < ApplicationRecord
  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users

  validates :email, uniqueness: true

  validates :name, presence: true, confirmation: true
  validates :email, presence: true, confirmation: true
  validates :password, presence: true, confirmation: true
  
  has_secure_password
end
