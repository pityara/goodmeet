class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :meetings
  has_one :profile, dependent: :destroy
  has_one :creator, dependent: :destroy
  belongs_to :status
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
