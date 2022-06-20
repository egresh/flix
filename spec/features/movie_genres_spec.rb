require "rails_helper"

RSpec.feature "Show Page Genres", type: :feature do
  it "Displays a list of associated genres on the show page" do
    movie = FactoryBot.create(:movie)
    genre = Genre.new(name: "Comedy")

    movie.genres << genre

    visit movie_path(movie)

    expect(page).to have_text(genre.name)
  end

  it "Allows genere selection and removal on the edit page" do
    signin_admin_user
    movie = FactoryBot.create(:movie)

    Genre.create!(name: "Comedy")
    Genre.create!(name: "Romance")
    Genre.create!(name: "Thriller")

    visit movie_path(movie)
    expect(page).not_to have_text("Comedy")
    expect(page).not_to have_text("Romance")
    expect(page).not_to have_text("Thriller")

    visit edit_movie_path(movie)

    check 'Comedy'
    check 'Romance'
    check 'Thriller'

    click_button "Update"

    expect(page).to have_text("Comedy")
    expect(page).to have_text("Romance")
    expect(page).to have_text("Thriller")
  end
end
