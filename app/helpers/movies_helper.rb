module MoviesHelper
  def nav_link_to(link_text, link_path)
    if current_page?(link_path)
      link_to link_text, link_path, class: "active"
    else
      link_to link_text, link_path
    end
  end

  def total_gross(movie)
    if movie.flop?
      "Flop!"
    else
      number_to_currency(movie.total_gross, precision: 0)
    end
  end

  def year_of(movie)
    movie.released_on.year
  end

  def average_stars(movie)
    if movie.average_stars.zero?
      content_tag(:strong, "No reviews")
    else
      pluralize(number_with_precision(movie.average_stars, precision: 1), "star")
    end
  end

  def main_image(movie)
    if movie.main_image.attached?
      image_tag movie.main_image.variant(resize_to_limit: [100, 100])
    else
      image_tag "placeholder.png"
    end
  end
end
