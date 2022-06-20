require "rails_helper"

RSpec.feature "Admin", type: :feature do

  let(:movie) { FactoryBot.create(:movie) }

  context "without Admin access" do
    let!(:user) { signin_user_with_email }

    scenario "movies can't be edited" do
      visit movie_path(movie)
      expect(page).not_to have_link('Edit')
    end

    scenario "movies can't be destroyed" do
      visit movie_path(movie)
      expect(page).not_to have_link('Delete')
    end
  end

  context "with Admin access" do
    let!(:admin) { signin_admin_user }

    scenario "movies can be edited" do

      visit movie_path(movie)

      click_link "Edit"

      expect(current_path).to eq(edit_movie_path(movie))
      fill_in("Title", with: "New Title")

      click_button "Update"

      expect(page).to have_text("successfully updated")
    end

    scenario "movies can be deleted" do

      visit movie_path(movie)

      click_link "Delete"

      expect(current_path).to eq(movies_path)
      expect(page).to have_text("successfully deleted")
      expect(Movie.count).to eq(0)
    end
  end
end
