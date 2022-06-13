module MoviesHelper
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
      pluralize(number_with_precision(movie.average_stars, precision: 1) , "star")
    end
  end

  def admin_buttons
    if current_user_admin?
      text = ''
      edit = link_to("Edit", edit_movie_path(@movie), class: 'button')
      delete = link_to("Delete", movie_path(@movie), class: "button", method: :delete, data: { confirm: 'Are you sure?' })

      text = <<~"EOC"
        <section class="admin">
          #{edit}
          #{delete}
        </section>
      EOC

      text.html_safe
    end
  end
end
