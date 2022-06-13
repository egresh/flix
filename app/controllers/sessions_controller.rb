class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:username_or_email]) ||
      User.find_by_username(params[:username_or_email])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      logger.info "Session[:indended_url] is: #{session[:indended_url]}"
      redirect_to (session[:intended_url] || @user), notice: "Welcome back #{@user.name}!"
      session[:intended_url] = nil
    else
      flash.now[:alert] = "Invalid password/email combination"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_url, notice: "Successfully signed out"
  end
end
