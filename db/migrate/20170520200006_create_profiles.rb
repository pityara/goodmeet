class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
    	t.references :user, foreign_key: true
    	t.string :name
    	t.has_attached_file :avatar
    	t.string :city
    	t.integer :age
    	t.float :rating

    	t.timestamps
    end
  end
end
