class ChangeDateTimeOnmeetingsToDate < ActiveRecord::Migration[5.0]
  def change
  	change_column :meetings, :date, :date
  end
end
