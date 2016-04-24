class Admin::StreamitemsController < ApplicationController
  before_action :require_login
  layout 'main'
  def index

  end

  def showStream
    datestr = params[:year].to_s + "-" + params[:month].to_s + "-" + params[:day].to_s
    @selected_date = Date.strptime(datestr, '%Y-%m-%d')
    @streamitems = Admin::Streamitem.where(date: @selected_date.strftime('%Y-%m-%d')).sorted

    render 'index'
  end

  def new
    datestr = params[:year].to_s + "-" + params[:month].to_s + "-" + params[:day].to_s
    @selected_date = Date.strptime(datestr, '%Y-%m-%d')
    @streamitem = Admin::Streamitem.new
  end

  def create
    # create a new stream item and pass it an episode to add.
    # dynamically assign position variable
    # save streamitem
    @newStreamitem = Admin::Streamitem.new(streamitems_params)
    @newStreamitem.date = Date.strptime(params[:admin_streamitem][:date], '%Y-%m-%d')
    @newStreamitem.position = get_next_position(@newStreamitem.date)

    if @newStreamitem.save
      # update playlist
      #File.open(Rails.root.join('lib', 'ices', 'playlist.txt'), 'a+') do |f|
      #  f.puts Rails.root.join('public', @newStreamitem.episode.mediafile.attachment_url)
      #end

      redirect_to(streamitems_show_path(:year => @newStreamitem.date.strftime('%Y'), :month => @newStreamitem.date.strftime('%m'), :day => @newStreamitem.date.strftime('%d')), notice: "The stream item has been added.")
    else
       render "new"
    end
  end

  def destroy
    @streamitem = Admin::Streamitem.find(params[:id]).destroy
    itemsToShift = Admin::Streamitem.where(date: @selected_date.strftime('%Y-%m-%d')).where("position > :positionToDelete", {positionToDelete: @streamitem.position}).sorted

    # rewrite order
    itemsToShift.each do |item|
      item.position = item.position - 1
      item.save
    end

    # rewrite playlist
    #@streamitemsUpdated = Admin::Streamitem.sorted
    #File.open(Rails.root.join('lib', 'ices', 'playlist.txt'), 'w') do |f|
    #  @streamitemsUpdated.each do |streamitemUpdated|
    #    f.puts Rails.root.join('public', @streamitemsUpdated.episode.mediafile.attachment_url)
    #  end
    #end

    redirect_to(admin_streamitems_path, notice:  "The episode has been removed.")
  end

  private
    def streamitems_params
      params.require(:admin_streamitem).permit(:episode_id)
    end

    def get_next_position(selected_date)
      #returns next start time for stream item.
      streamitems = Admin::Streamitem.where(date: selected_date.strftime('%Y-%m-%d')).sorted
      if streamitems.empty?
        newPosition = 1
      else
        newPosition = streamitems.last.position + 1
      end
      return newPosition
    end
end
