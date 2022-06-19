module FavoritesHelper
  def fav_or_unfav_button(movie, fanned)
    if fanned
      button_to "Unlike Movie", movie_favorite_path(movie, fanned), method: :delete
    else
      button_to "Like Movie", movie_favorites_path(@movie)
    end
  end
end
