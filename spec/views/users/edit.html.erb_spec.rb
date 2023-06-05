require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      fname: "MyString",
      lname: "MyString",
      email: "MyString",
      session_token: "MyString",
      password_digest: "MyString",
      gh_username: "MyString"
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do

      assert_select "input[name=?]", "user[fname]"

      assert_select "input[name=?]", "user[lname]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[session_token]"

      assert_select "input[name=?]", "user[password_digest]"

      assert_select "input[name=?]", "user[gh_username]"
    end
  end
end
