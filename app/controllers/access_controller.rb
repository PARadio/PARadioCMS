class AccessController < ApplicationController
  layout 'main'
  def index
    #displays text and links
  end

  def login
    #displays login form
  end

  def attempt_login
    if params[:email].present? && params[:password].present?
      found_user = User.where(:username=>params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      #TODO: MARK USER AS LOGGED IN
      flash[:notice] = "You are now logged in."
      redirect_to(:action => 'index')
    else
      flash[:notice]= "Invalid username/password."
      redirect_to(:action => 'login')
    end
  end
  def logout
    #TODO: MARK LOGGED OUT
    flash[:notice] = "Logged out"
    redirect_to(:action => 'login')
  end
end
