module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    # user.id is BSON object, save as string with to_s
    session[:user_id] = user.id.to_s
    logger.debug "Logged in user #{user.id.to_s}"
    # store current user
    @current_user = user
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns true if the given user is admin
  def is_admin?()
    current_user.is_admin unless current_user.nil?
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(_id: user_id) rescue nil
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id) rescue nil
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
