class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    flash[:notice] = "This is just a sample app; Don't take it too seriously"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome to sample Ruby App'
      redirect_to user_path(@user.id)
    else
      render 'users/new'
    end

  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
