require "rails_helper"

RSpec.describe "Signup", type: :feature do
  it "links to the signup page from the header" do
    visit root_path
    click_link "Sign Up"

    expect(current_path).to eq(signup_path)
  end

  it "creates a new user from the signin page" do
    visit root_path
    click_link "Sign Up"

    user = FactoryBot.build(:user)

    fill_in("Username", with: user.username)
    fill_in("Password", with: user.password)
    fill_in("Password confirmation", with: user.password_confirmation)
    fill_in("Email", with: user.email)
    fill_in("Name", with: user.name)

    click_button "Create Account"

    expect(page).to have_text("Thanks for signing up")
  end
end
