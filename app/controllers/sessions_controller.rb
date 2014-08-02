class SessionsController < ApplicationController

  before_action :redirect_signed_in_user, only:[:new,:create]

  def new
    if signed_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid Username/Password'
      render 'sessions/new'
    end

  end

  def destroy
    sign_out current_user
    redirect_to root_path
  end



end
