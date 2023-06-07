require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:rating) }
    it { should validate_numericality_of(:rating).only_integer.is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5).with_message('must be between 1 and 5') }
    it { should validate_presence_of(:rated_user_id) }
  end

  describe 'associations' do
    it { should belong_to(:author) }
    it { should belong_to(:rated_user)}
  end
end