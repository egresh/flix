require "rails_helper"

RSpec.feature "Signin", type: :feature do
  context "Without an intended URL" do
    scenario "signs in a user using an email address and redirects to the user show page" do
      user = signin_user_with_email
      expect(page).to have_text("Welcome back")
      expect(current_path).to eq(user_path(user))
    end

    scenario "signs in a user using a username and redirects to the user show page" do
      user = signin_user_with_username
      expect(page).to have_text("Welcome back")
      expect(current_path).to eq(user_path(user))
    end
  end

  context "With an intended URL" do
    scenario 'signs in a user using an email address and redirects to the intended url' do
      user = FactoryBot.create(:user)

      visit users_url

      expect(current_path).to eq(signin_path)
      fill_in("username_or_email", with: user.email)
      fill_in("password", with: user.password)

      click_button "Sign In"

      expect(current_path).to eq(users_path)
    end
  end

end
