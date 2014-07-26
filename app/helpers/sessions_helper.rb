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
    self.current_user = nil
    cookies.delete :remember_token
  end


  def signed_in?
    return !current_user.nil?
  end

end
