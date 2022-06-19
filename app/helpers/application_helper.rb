module ApplicationHelper
  def admin_buttons(object)
    if current_user_admin?
      text = ""
      edit = link_to("Edit", edit_movie_path(@movie), class: "button")
      delete = link_to("Delete", movie_path(@movie), class: "button", method: :delete, data: {confirm: "Are you sure?"})

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
