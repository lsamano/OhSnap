class ApplicationController < ActionController::Base
  before_action :authorized
  helper_method :logged_in?, :current_user

  def authorized
    redirect_to "/login" unless logged_in?
  end

  def current_user
  if session[:user_id]
    @user = User.find_by(id: session[:user_id])
  else
  end
end

def logged_in?
  !!current_user
end


end
