class Meeting < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_and_belongs_to_many :users
	validates :title, :description, presence: true
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
end
