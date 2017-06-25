class AddDefaultStatusToUser < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :status_id, from: "", to: 3
  end
end
