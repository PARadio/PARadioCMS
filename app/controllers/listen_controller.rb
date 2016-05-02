class ListenController < ApplicationController
  layout 'main'
  def index
    @currentItem = Admin::Streamitem.getCurrent
  end
end
