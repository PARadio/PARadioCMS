class StreamitemsController < ApplicationController
  layout 'main'
  def index
    @streamitems = Streamitem.sorted
  end

  def new
    @streamitem = Streamitem.new
  end

  def create
    # create a new stream item and pass it an episode to add.
    # dynamically assign position variable
    # save streamitem
    @streamitem = Streamitem.new(streamitems_params)
    @streamitem.position=get_next_position
    if @streamitem.save
      redirect_to streamitems_path, notice: "The stream item has been added."
    else
       render "new"
    end
  end

  def destroy
    @streamitem = Streamitem.find(params[:id]).destroy
    itemsToShift = Streamitem.where("position > :positionToDelete", {positionToDelete: @streamitem.position})

    # rewrite order
    itemsToShift.each do |item|
      item.position = item.position - 1
      item.save
    end

    redirect_to(streamitems_path, notice:  "The episode has been removed.")
  end

  private
    def streamitems_params
      params.require(:streamitem).permit(:episode_id)
    end

    def get_next_position
      #returns next position for stream item.
      return Streamitem.all.size + 1
    end
end
