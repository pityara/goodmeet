class CreateCreators < ActiveRecord::Migration[5.0]
  def change
    create_table :creators do |t|
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
