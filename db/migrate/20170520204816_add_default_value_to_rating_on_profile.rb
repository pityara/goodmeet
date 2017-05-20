class AddDefaultValueToRatingOnProfile < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :profiles, :rating, from: nil, to: 0
  end
end
