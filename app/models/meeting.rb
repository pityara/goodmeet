class Meeting < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_and_belongs_to_many :users
	validates :title, :description, :image_url, presence: true
	validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'должен указывать на изображение формата GIF, JPG или PNG.'
	}
end
