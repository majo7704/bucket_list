class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def ensure_authenticated
    redirect_to login_path unless(logged_in?)
  end 

  def logged_in?
    session[:user_id].present?
  end 

  def current_user
    User.find(session[:user_id])
  end
end
