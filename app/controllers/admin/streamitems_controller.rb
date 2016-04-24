class Admin::StreamitemsController < ApplicationController
  before_action :require_login
  layout 'main'
  def index
    @streamitems = Admin::Streamitem.sorted
  end

  def new
    @streamitem = Admin::Streamitem.new
  end

  def create
    # create a new stream item and pass it an episode to add.
    # dynamically assign position variable
    # save streamitem
    @newStreamitem = Admin::Streamitem.new(streamitems_params)
    @newStreamitem.start_time = get_next_start_time

    if @newStreamitem.save
      # update playlist
      File.open(Rails.root.join('lib', 'ices', 'playlist.txt'), 'a+') do |f|
        f.puts Rails.root.join('public', @newStreamitem.episode.mediafile.attachment_url)
      end

      redirect_to(admin_streamitems_path, notice: "The stream item has been added.")
    else
       render "new"
    end
  end

  def destroy
    @streamitem = Admin::Streamitem.find(params[:id]).destroy
    itemsToShift = Admin::Streamitem.where("start_time > :positionToDelete", {positionToDelete: @streamitem.start_time})

    # rewrite order
    itemsToShift.each do |item|
      item.start_time = item.start_time - @streamitem.episode.duration
      item.save
    end

    # rewrite playlist
    @streamitemsUpdated = Admin::Streamitem.sorted
    File.open(Rails.root.join('lib', 'ices', 'playlist.txt'), 'w') do |f|
      @streamitemsUpdated.each do |streamitemUpdated|
        f.puts Rails.root.join('public', @streamitemsUpdated.episode.mediafile.attachment_url)
      end
    end

    redirect_to(admin_streamitems_path, notice:  "The episode has been removed.")
  end

  private
    def streamitems_params
      params.require(:admin_streamitem).permit(:episode_id)
    end

    def get_next_start_time
      #returns next start time for stream item.
      streamitems = Admin::Streamitem.sorted
      if Admin::Streamitem.count == 0
        newStart = Time.now;
      else
        newStart = streamitems.last.start_time + streamitems.last.episode.duration.seconds;
      end
      return newStart
    end
end
