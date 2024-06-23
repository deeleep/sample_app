module SessionsHelper
  # Log in as the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id  # Corrected 'encypted' to 'encrypted'
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])  # Check if there's a user ID in the session
      @current_user ||= User.find_by(id: session[:user_id])  # Memoize the current user if not already set
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user  # Corrected 'log_in user = User' to 'log_in user'
        @current_user = user  # Corrected '@currrent_user' to '@current_user'
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end
 

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end


  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end
end