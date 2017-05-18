class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :comments, dependent: :destroy
  has_secure_password
end
