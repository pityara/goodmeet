class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :type

      t.timestamps
    end
  end
end
