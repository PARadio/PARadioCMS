class StreamitemsController < ApplicationController
  layout 'main'
  def index
    @streamitems = Streamitem.all
    @episodes = Array.new
    @streamitems.each do |streamitem|
      episode = Episode.find(streamitem.episode_id)
      @episodes.push episode
    end
  end

  def new
    @streamitem = Streamitem.new
  end

  def create
    @streamitem = Streamitem.new(streamitems_params)
    allStreamitems = Streamitem.find(:all, :order => "position")
    if allStreamitems.empty
      @streamitem.position = 1
    else
      @streamitem.position = allStreamitems.last.position + 1
    end

    if @streamitem.save
      redirect_to streamitems_path, notice: "The stream item has been added."
    else
       render "new"
    end
  end

  def destroy
    @streamitem = Streamitem.find(params[:id])
    @itemsToShift = Streamitem.where("position > :positionToDelete", {positionToDelete: @streamitem.position})
    @streamitem.destroy

    # rewrite order
    @itemsToShift.each do |item|
      item.position = item.position - 1
      item.save
    end

    redirect_to streamitems_path, notice:  "The episode has been removed."
  end

  private
     def streamitems_params
     params.require(:streamitem).permit(:episode_id)
  end
end
