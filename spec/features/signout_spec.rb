require 'rails_helper'

RSpec.describe "Signout", type: :feature do
  it "signs out a user" do
    signin_user_with_email
    click_link "Sign Out"
    expect(page).to have_text("Successfully signed out")
  end
end
