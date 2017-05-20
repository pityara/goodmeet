class RemoveImageUrlFromMeetings < ActiveRecord::Migration[5.0]
  def change
  	remove_column :meetings, :image_url, :string
  end
end
