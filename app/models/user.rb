class User < ApplicationRecord
  attr_reader :password
  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password_digest, :fname, :lname, presence: true
  validates :password, length: {minimum: 6}, allow_nil: true
  validates :gh_username, uniqueness: true, allow_nil: true

  has_many :given_ratings, class_name: 'Rating', foreign_key: 'author_id'
  has_many :received_ratings, class_name: 'Rating', foreign_key: 'rated_user_id'

  after_initialize :ensure_session_token

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
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

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
