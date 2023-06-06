class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.integer :author_id, null: false

      t.timestamps
    end
    add_foreign_key :posts, :users, column: :author_id
  end
end
