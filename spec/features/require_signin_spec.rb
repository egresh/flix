require "rails_helper"

RSpec.describe "Require signin", type: :feature do
  it "requires signing in before accessing users_path" do
    visit users_path
    expect(page).to have_current_path(signin_path)
  end

  let(:user) { FactoryBot.create(:user) }

  it "requires signing in before accessing edit_user_path" do
    visit user_path(user)
    expect(page).to have_current_path(signin_path)
  end

  it "is not required to view the new action" do
    visit new_user_path
    expect(page).to have_current_path(new_user_path)
  end
end
