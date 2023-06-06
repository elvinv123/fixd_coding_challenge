require 'rails_helper'

RSpec.describe "ratings/edit", type: :view do
  let(:rating) {
    Rating.create!()
  }

  before(:each) do
    assign(:rating, rating)
  end

  it "renders the edit rating form" do
    render

    assert_select "form[action=?][method=?]", rating_path(rating), "post" do
    end
  end
end
