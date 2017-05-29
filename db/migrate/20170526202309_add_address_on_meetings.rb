class AddAddressOnMeetings < ActiveRecord::Migration[5.0]
  def change
  	add_column :meetings, :latitude, :float
  	add_column :meetings, :longitude, :float
  	add_column :meetings, :address, :string
  end
end
