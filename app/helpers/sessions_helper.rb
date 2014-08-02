module SessionsHelper

  def current_user
    @current_user ||= User.find_by(remember_token: User.digest(cookies[:remember_token]))
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token,User.digest(remember_token))
    self.current_user = user
  end

  def sign_out(current_user)
    current_user.update_attribute(:remember_token,User.digest(User.new_remember_token))
    cookies.delete :remember_tokens
    self.current_user = nil

  end

  def signed_in?
    return !current_user.nil?
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def redirect_signed_in_user
    redirect_back_or current_user if signed_in?

  def correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to root_path
    end
  end

  def signed_in_user

    if !signed_in?
      flash[:notice] = 'Please Sign in to complete this action'
      store_location
      redirect_to signin_path
    end

>>>>>>> microposts
  end


end
