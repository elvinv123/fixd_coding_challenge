class Rating < ApplicationRecord
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "must be between 1 and 5" }
  belongs_to :author, class_name: 'User'
  belongs_to :rated_user, class_name: 'User'
end
