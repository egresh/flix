require "rails_helper"

RSpec.feature User, type: :feature do
  let!(:user) { signin_user_with_email }

  scenario "index page lists users" do
    user2 = FactoryBot.create(:user, name: "Jane Doe")

    visit users_path

    expect(page).to have_xpath("//h1[contains(.,'#{User.count} Users')]")

    # A more precise search using xpath is needed since the signed in user's
    # name will appear in the header. 
    expect(page).to have_xpath("//a[contains(.,'#{user.name}')]")
    expect(page).to have_xpath("//a[contains(.,'#{user2.name}')]")
  end

  it "show page shows users' details" do
    visit user_path(user)

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
    expect(page).to have_text(user.username)
  end

  it "creates a new user" do
    visit new_user_path

    fill_in("Name", with: "John Smith")
    fill_in("Email", with: "jsmith@example.org")
    fill_in("Username", with: "jsmithy01")
    fill_in("Password", with: "secret")
    fill_in("Password confirmation", with: "secret")

    click_button "Create Account"

    expect(page).to have_text("Thanks for signing up John Smith")
  end

  it "edits an existing user" do
    visit edit_user_path(user)

    fill_in("Name", with: "Bill Doe")

    click_button "Update Account"

    expect(page).to have_text("Bill Doe")
    expect(current_path).to eq user_path(user)
  end

  it "deletes an existing user" do
    visit user_path(user)

    click_link "Delete Account"

    expect(current_path).to eq(movies_path)
    expect(page).not_to have_text(user.name)
    expect(page).to have_text("Account deleted!")
  end
end
