class Post < ApplicationRecord
  validates :title, :body, presence: true

  belongs_to :author, class_name: 'User'
  has_many :comments, class_name: 'Comment', foreign_key: 'post_id'
end
