require "byebug"
require "rails_helper"

RSpec.describe User, type: :feature do
  it "index page lists users" do
    u1 = FactoryBot.create(:user)
    u2 = FactoryBot.create(:user)

    visit users_path

    expect(page).to have_text(u1.email)
    expect(page).to have_text(u2.email)
  end

  it "show page shows users' details" do
    u1 = FactoryBot.create(:user)

    visit user_path(u1)

    expect(page).to have_text("John Smith")
  end

  it "creates a new user" do
    visit new_user_path

    fill_in("Name", with: "John Smith")
    fill_in("Email", with: "jsmith@example.org")
    fill_in("Password", with: "secret")
    fill_in("Password confirmation", with: "secret")

    click_button "Create Account"

    expect(page).to have_text("John Smith")
  end

  it "edits an existing user" do
    u1 = FactoryBot.create(:user)

    visit edit_user_path(u1)

    fill_in("Name", with: "Bill Doe")

    click_button "Update Account"

    expect(page).to have_text("Bill Doe")
    expect(current_path).to eq user_path(u1)
  end

  it "deletes an existing user" do
    u1 = FactoryBot.create(:user)

    visit user_path(u1)

    click_link "Delete Account"

    expect(current_path).to eq(users_path)
    expect(page).not_to have_text(u1.name)
  end
end
