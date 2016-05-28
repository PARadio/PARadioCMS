class Api::V1::StreamitemsController < ApplicationController
  def index
    @Streamitems= Streamitem.all
  end
end
