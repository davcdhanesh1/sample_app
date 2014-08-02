class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update_attributes(edit_user_params)

    if @user.save
      flash[:success] = 'New changes Saved Successfully'
      redirect_to user_path(@user.id)
    else
      render 'users/edit'
    end

  end

  def create

    @user = User.new(create_user_params)

    if @user.save
      flash[:success] = 'Welcome to sample Ruby App'
      sign_in @user
      redirect_to user_path(@user.id)
    else
      render 'users/new'
    end

  end


  private

  private

  def edit_user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def create_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
