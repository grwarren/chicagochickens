class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  def set_current_user
    user_id = session[:user_id].nil? ? params[:user_id] : session[:user_id]
    @current_user ||= User.find_by(user_id: user_id.to_i) rescue nil
  end
end
