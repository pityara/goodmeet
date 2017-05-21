class Creator < ApplicationRecord
	has_many :meetings
	belongs_to :user
end
