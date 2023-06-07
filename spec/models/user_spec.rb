require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_name)}
    it { should validate_presence_of(:session_token)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_presence_of(:fname)}
    it { should validate_presence_of(:lname)}
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { should have_many(:posts)}
    it { should have_many(:comments)}
    it { should have_many(:given_ratings)}
    it { should have_many(:received_ratings)}
  end
end