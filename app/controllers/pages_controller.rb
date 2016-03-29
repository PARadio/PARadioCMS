class PagesController < ApplicationController
  def index
    @pages= Page.sorted
  end

  def show
  end

  def new
  end

  def edit
  end

  def delete
  end
end
