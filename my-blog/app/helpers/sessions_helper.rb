module SessionsHelper
  # Logs in the given user.
  def login(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns true if the user is an admin, false otherwise.
  def admin?
  	if logged_in?
      current_user.type == "Administrator"
    else
      false
    end
  end

  # Returns true if the user argument is the currently logged in user.
  def is_logged_in_user?(user)
    if logged_in?
      current_user.username == user.username
    else
      false
    end
  end
end
