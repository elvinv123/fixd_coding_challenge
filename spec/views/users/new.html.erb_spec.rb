require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      fname: "MyString",
      lname: "MyString",
      email: "MyString",
      session_token: "MyString",
      password_digest: "MyString",
      gh_username: "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[fname]"

      assert_select "input[name=?]", "user[lname]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[session_token]"

      assert_select "input[name=?]", "user[password_digest]"

      assert_select "input[name=?]", "user[gh_username]"
    end
  end
end
