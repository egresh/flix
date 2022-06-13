class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Thanks for signing up #{@user.name}"
    else
      render :new, alert: "Unable to complete registration"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "Account deleted!"
  end

  private

  def user_params
    params.require(:user)
      .permit(:name, :email, :password, :password_confirmation, :username)
  end

  def require_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to movies_url, alert: "No, no, no"
    end
  end
end
