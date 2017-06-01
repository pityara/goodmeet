class ChangeStatusOnUsers < ActiveRecord::Migration[5.0]
  def change
  	change_table :users do |t|
  		t.remove :status
  		t.references :status, foreign_key: true
	end
  end
end
