class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_path, notice: 'New User Created'
    else
      render new_user_path
    end
  end

  def new
    @user =  User.new
  end

  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:user_id, :name)
  end
end
