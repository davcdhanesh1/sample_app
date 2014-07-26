class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user_path(user.id)
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
