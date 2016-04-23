class UsersController < ApplicationController
  before_action :require_login, only: [:index, :create]

  def new

  end 
  def create

  end

  def index

  end
end
