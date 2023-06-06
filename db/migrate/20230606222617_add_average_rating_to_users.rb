class AddAverageRatingToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :avg_rating, :float
  end
end
