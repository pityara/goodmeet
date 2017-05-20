class AddImageToMeeting < ActiveRecord::Migration[5.0]
  	def self.up
  		change_table :meetings do |t|
  		t.has_attached_file :image
  		end
  	end

  	def self.down
  		drop_attached_file :meetings, :image
  	end
end
