class Rating < ApplicationRecord
  validates :author_id, :rated_user_id, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "must be between 1 and 5" }
  validates :rated_user_id, exclusion: { in: ->(rating) { [rating.author_id] } }

  belongs_to :author, class_name: 'User'
  belongs_to :rated_user, class_name: 'User'

  after_create :update_user_avg_rating

  private
  def update_user_avg_rating
    rated_user = User.find(self.rated_user.id)
    received_ratings = rated_user.received_ratings
  
    if received_ratings.empty?
      new_avg = 0.0
    else
      total_ratings = received_ratings.length
      total_sum = received_ratings.sum { |rating| rating.rating.to_f }
      new_avg = total_sum / total_ratings
    end
  
    begin
      rated_user.avg_rating = new_avg
      rated_user.save!
    rescue StandardError => e
      puts "Error saving new average rating: #{e.message}"
    end
  end
end
