class UsersController < ApplicationController
  before_action :require_login
  layout 'main'
  def new
    @user = User.new()
  end

  def create
    @user=User.new(user_params)
    if @user.save()
      flash[:notice]="User created successfully"
      redirect_to(user_path(@user))
    else
      render('new')
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice]="User updated successfully"
      redirect_to(user_path(@user))
    else
      render('edit')
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:notice]= "User deleted successfully"
    redirect_to({:action=>'index'})
  end

  private
    def user_params
      params.require(:user).permit([:first_name, :last_name, :email, :stage,
      :password, :password_confirmation, :access_level])
    end
end
