class RenameStatusType < ActiveRecord::Migration[5.0]
  def change
  	change_table :statuses do |t|
  		t.rename :type, :name
end
  end
end
