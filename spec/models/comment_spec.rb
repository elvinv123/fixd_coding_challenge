require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:author_id) }
    it { should validate_presence_of(:post_id) }
  end

  describe 'associations' do
    it { should belong_to(:author) }
    it { should belong_to(:post)}
  end
end
