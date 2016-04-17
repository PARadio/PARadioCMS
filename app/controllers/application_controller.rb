class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def require_login
      unless session[:user_id]
        flash[:notice]= "you must be logged in to access this"
        redirect_to(login_path)
      end
    end
end
