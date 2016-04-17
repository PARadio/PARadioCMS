class Admin::AccessController < ApplicationController
  layout 'main'
  def index
    #displays text and links
  end

  def login
    #displays login form
  end

  def attempt_login
    if params[:email].present? && params[:password].present?
      found_user = User.where(:email=>params[:email]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      # mark user logged in
      session[:user_id] = authorized_user.id
      session[:user_first_name] = authorized_user.first_name
      session[:user_last_name] = authorized_user.last_name
      session[:user_email] = authorized_user.email
      flash[:notice] = "You are now logged in."
      redirect_to(:action => 'index')
    else
      flash[:notice]= "Invalid username/password."
      redirect_to(:action => 'login')
    end
  end
  def logout
    # MARK LOGGED OUT
    session[:user_id] = nil
    session[:user_first_name] = nil
    session[:user_last_name] = nil

    flash[:notice] = "Logged out"
    redirect_to(:action => 'login')
  end
end
