class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to users_url, notice: "New User Created"
    else
      flash.now[:error] = "Error creating user #{@user.errors.messages}"
      render new_user_path
    end
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all.order_by(:user_id.asc)
  end

  def edit
  end

  def update
    puts "user_params = " + user_params.inspect
    if @user.update(user_params)
      redirect_to users_url, notice: "User #{@user.user_id} was successfully updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "User #{@user.user_id} deleted"
  end

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find_by(user_id: params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(user_id: params[:id])
  end

  def user_params
    params.require(:user).permit!
  end
end
