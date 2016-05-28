class ListenController < ApplicationController
  layout 'main'
  def index
    @currentItem = Livestream::Engine.getCurrent
  end
end
