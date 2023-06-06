require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  let(:comment) {
    Comment.create!(
      author_id: 1,
      post_id: 1,
      body: "MyString"
    )
  }

  before(:each) do
    assign(:comment, comment)
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(comment), "post" do

      assert_select "input[name=?]", "comment[author_id]"

      assert_select "input[name=?]", "comment[post_id]"

      assert_select "input[name=?]", "comment[body]"
    end
  end
end
