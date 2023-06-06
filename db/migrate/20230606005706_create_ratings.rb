class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :author_id
      t.integer :rated_user_id
      t.integer :rating
      t.timestamps
    end
    add_foreign_key :ratings, :users, column: :author_id
    add_foreign_key :ratings, :users, column: :rated_user_id
  end
end
