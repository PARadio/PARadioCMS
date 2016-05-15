class Api::StreamitemsController < ApplicationController
  def index
    @Streamitems= Streamitem.all
  end
end
