class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
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
  def correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to root_path
    end
  end

  private

  def edit_user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def create_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def signed_in_user

    if !signed_in?
      flash[:notice] = 'Please Sign in to complete this action'
      store_location
      redirect_to signin_path
    end

  end

end
