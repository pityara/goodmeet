class AddCreatorToMeeting < ActiveRecord::Migration[5.0]
  def change
  	add_column :meetings, :creator_id, :integer, foreign_key: true
  end
end
