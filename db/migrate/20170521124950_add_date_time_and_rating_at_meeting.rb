class AddDateTimeAndRatingAtMeeting < ActiveRecord::Migration[5.0]
  def change
  	add_column :meetings, :date, :datetime
  	add_column :meetings, :required_rating, :float, default: 0.0
  end
end
