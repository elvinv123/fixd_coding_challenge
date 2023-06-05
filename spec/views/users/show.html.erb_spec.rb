require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    assign(:user, User.create!(
      fname: "Fname",
      lname: "Lname",
      email: "Email",
      session_token: "Session Token",
      password_digest: "Password Digest",
      gh_username: "Gh Username"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Fname/)
    expect(rendered).to match(/Lname/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Session Token/)
    expect(rendered).to match(/Password Digest/)
    expect(rendered).to match(/Gh Username/)
  end
end
