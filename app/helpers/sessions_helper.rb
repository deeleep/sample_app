module SessionsHelper
    # Log in as the given user
    def log_in (user)
        session[ :user_id ] = user.id
    end

    def current_user
        if session[:user_id]  # Check if there's a user ID in the session
          @current_user ||= User.find_by(id: session[:user_id])  # Memoize the current user if not already set
        end
      end

    def logged_in?
        !current_user.nil?
    end
      
    def log_out
      reset_session
      @current_user = nil 
    end
end
