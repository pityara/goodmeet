class CreateUsersAndMeetings < ActiveRecord::Migration[5.0]
  def change
    create_table :users_meetings, id; false do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :meeting, index: true
    end
  end
end