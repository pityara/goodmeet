class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :meetings
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  has_secure_password
end
