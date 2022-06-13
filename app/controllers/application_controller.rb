class ApplicationController < ActionController::Base
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?
    !current_user.blank?
  end

  def current_user_admin?
    current_user&.admin?
  end

  helper_method :current_user, :current_user?, :current_user_admin?

  def require_signin
    unless current_user?
      logger.info "Logging in, request_url: #{request.url}"
      session[:intended_url] = request.url
      redirect_to(signin_url, alert: "Please sign in first")
    end
  end

  def require_admin
    unless current_user_admin?
      redirect_to movies_url, notice: "Unauthorized Access"
    end
  end
end
