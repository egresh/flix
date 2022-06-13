module SessionsHelper
  def render_header_buttons
    out = if current_user?
      user = link_to(current_user.name, current_user)
      settings = link_to("Account Settings", current_user, class: "button")
      signout = link_to("Sign Out", session_path, method: :delete, data: {confirm: "Are you sure?"}, class: "button")
      <<~EOC
        <li>
          #{user}
        </li>
        <li>
          #{signout}
        <li>
        #{settings}
        </li>
      EOC
    else
      signin = link_to("Sign In", signin_path, class: "button")
      signup = link_to("Sign Up", signup_path, class: "button")
      <<~EOC
        <li>
          #{signin}
        </li>
        <li>
          #{signup}
        </li>
      EOC
    end
    out.html_safe
  end
end
