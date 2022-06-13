def signin_user_with_email
  user = FactoryBot.create(:user)
  visit signin_path

  fill_in(:username_or_email, with: user.email)
  fill_in(:password, with: user.password)

  click_button "Sign In"
  user
end

def signin_user_with_username
  user = FactoryBot.create(:user)
  visit signin_path

  fill_in(:username_or_email, with: user.username)
  fill_in(:password, with: user.password)

  click_button "Sign In"
  user
end

def signin_admin_user
  admin = FactoryBot.create(:user, admin: true)

  visit signin_path
  fill_in(:username_or_email, with: admin.username)
  fill_in(:password, with: admin.password)

  click_button "Sign In"
  admin
end
