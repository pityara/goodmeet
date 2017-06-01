class ChangeDefaultStatusOfUsers < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :users, :status_id, to: 1
  end
end
