class ListenController < ApplicationController
  layout 'main'
  def index
    @currentItem = Streamitem.getCurrent
  end
end
