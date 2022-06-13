module UsersHelper
  def profile_image(user)
    url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag(url, alt: user.name)
  end

  def expose_edit_delete_buttons
    if @user == current_user
      delete = link_to("Delete Account", user_path(@user), method: :delete, data: {confirm: "Are you sure?"}, class: "button delete")
      edit = link_to("Edit Account", edit_user_path(@user), class: "button edit")

      html = <<~EOC
        <div class="actions">
          #{edit}
          #{delete}
        </div>
      EOC
      html.html_safe
    end
  end
end
