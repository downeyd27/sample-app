module SessionsHelper
  def sign_in
    cookies.permanent[:remember_token] = user.remember_token
    # Next line not necessary for sign_in method in a route with redirect_to,
    # but a good idea incase used without a redirect
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
end
