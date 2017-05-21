class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :meetings
  has_one :profile, dependent: :destroy
  has_one :creator, dependent: :destroy
  has_secure_password
end
