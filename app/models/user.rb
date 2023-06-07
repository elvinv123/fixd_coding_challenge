class User < ApplicationRecord
  require 'net/http'
  attr_reader :password
  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password_digest, :fname, :lname, presence: true
  validates :password, length: {minimum: 6}, allow_nil: true
  validates :gh_username, uniqueness: true, allow_nil: true

  has_many :posts, class_name: 'Post', foreign_key: 'author_id', dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: 'author_id', dependent: :destroy
  has_many :given_ratings, class_name: 'Rating', foreign_key: 'author_id', dependent: :destroy
  has_many :received_ratings, class_name: 'Rating', foreign_key: 'rated_user_id', dependent: :destroy

  after_initialize :ensure_session_token
  after_commit :create_4_star_post, on: :update

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def fetch_gh_events(page = 1, per_page = 25)
    url = "https://api.github.com/users/#{gh_username}/events?page=#{page}&per_page=#{per_page}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    events = JSON.parse(response)
    return events.kind_of?(Array) ? events : []
    rescue StandardError => e
      puts "Error fetching GitHub events: #{e.message}"
      []
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  private

  def create_4_star_post
    return unless avg_rating && avg_rating >= 4 && posts.where(title: "Passed 4 stars! 🎉").empty?
    posts.create(title: "Passed 4 stars! 🎉", body: "🎉 I passed 4 stars yay 🎉")
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
