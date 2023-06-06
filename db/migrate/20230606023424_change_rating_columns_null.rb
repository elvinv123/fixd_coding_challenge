class ChangeRatingColumnsNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :ratings, :author_id, false
    change_column_null :ratings, :rated_user_id, false
    change_column_null :ratings, :rating, false
  end
end
