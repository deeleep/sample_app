module SessionsHelper
  # Log in as the given user
  def log_in(user)
    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id  # Corrected 'encypted' to 'encrypted'
    cookies.permanent[:remember_token] = user.remember_token
  end


  def current_user
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.session_token
        @current_user = user
      end
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  # The above code is better than this code we are using the above code, it does not have vulnerability
  # def current_user
  #   if (user_id = session[:user_id])  # Check if there's a user ID in the session
  #     @current_user ||= User.find_by(id: session[:user_id])  # Memoize the current user if not already set
  #   elsif (user_id = cookies.encrypted[:user_id])
  #     user = User.find_by(id: user_id)
  #     if user && user.authenticated?(cookies[:remember_token])
  #       log_in user  # Corrected 'log_in user = User' to 'log_in user'
  #       @current_user = user  # Corrected '@currrent_user' to '@current_user'
  #     end
  #   end
  # end
  

  def current_user?(user)
     user && user == current_user
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

  def store_location 
    session[:forwarding_url] = request.original_url if request.get?

  end

end




# module SessionsHelper

#   # Logs in the given user.
#   def log_in(user)
#     session[:user_id] = user.id
#     # Guard against session replay attacks.
#     # See https://bit.ly/33UvK0w for more.
#     session[:session_token] = user.session_token
#   end

#   # Remembers a user in a persistent session.
#   def remember(user)
#     user.remember
#     cookies.permanent.encrypted[:user_id] = user.id
#     cookies.permanent[:remember_token] = user.remember_token
#   end

#   # Returns the user corresponding to the remember token cookie.
#   def current_user
#     if (user_id = session[:user_id])
#       user = User.find_by(id: user_id)
#       if user && session[:session_token] == user.session_token
#         @current_user = user
#       end
#     elsif (user_id = cookies.encrypted[:user_id])
#       user = User.find_by(id: user_id)
#       if user && user.authenticated?(cookies[:remember_token])
#         log_in user
#         @current_user = user
#       end
#     end
#   end

#   # Returns true if the given user is the current user.
#   def current_user?(user)
#     user && user == current_user
#   end

#   # Returns true if the user is logged in, false otherwise.
#   def logged_in?
#     !current_user.nil?
#   end

#   # Forgets a persistent session.
#   def forget(user)
#     user.forget
#     cookies.delete(:user_id)
#     cookies.delete(:remember_token)
#   end

#   # Logs out the current user.
#   def log_out
#     forget(current_user)
#     reset_session
#     @current_user = nil
#   end

#   # Stores the URL trying to be accessed.
#   def store_location
#     session[:forwarding_url] = request.original_url if request.get?
#   end
# end



