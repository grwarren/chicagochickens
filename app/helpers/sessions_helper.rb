module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    # user.id is BSON object, save as string with to_s
    session[:user_id] = user.id.to_s
    logger.debug "Logged in user #{user.id.to_s}"
    # store current user
    @current_user = user
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns the current logged-in user (if any).
  def current_user
    logger.debug "CURRENT USER CHECK #{session[:user_id]}"
    @current_user ||= User.find_by(_id: session[:user_id]) rescue nil
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
end
