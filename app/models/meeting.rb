class Meeting < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_and_belongs_to_many :users
  geocoded_by :address
  after_validation :geocode
	validates :title, :description, :date, :required_rating, presence: true
  validates_date :date, :after => :today,
                        :after_message => "должна быть позже сегодняшнего дня"
  validates_numericality_of :required_rating, greater_than_or_equal_to: 0
  	has_attached_file :image, 
    	styles: { medium: "300x300#", thumb: "100x100#" },
    	:convert_options => {
    	:thumb => "-quality 75 -strip" },
    	:storage => :s3,
    	:s3_credentials => {
      	:bucket => ENV['S3_BUCKET_NAME'],
      	:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      	:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
      	:region => ENV['AWS_REGION']
    	},
    	:path => ":filename.:extension",
    	:default_url => "meeting_img.png"

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    belongs_to :creator
end
