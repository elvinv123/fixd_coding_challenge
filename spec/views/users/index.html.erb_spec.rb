require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        fname: "Fname",
        lname: "Lname",
        email: "Email",
        session_token: "Session Token",
        password_digest: "Password Digest",
        gh_username: "Gh Username"
      ),
      User.create!(
        fname: "Fname",
        lname: "Lname",
        email: "Email",
        session_token: "Session Token",
        password_digest: "Password Digest",
        gh_username: "Gh Username"
      )
    ])
  end

  it "renders a list of users" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Fname".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Lname".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Session Token".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Password Digest".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Gh Username".to_s), count: 2
  end
end
