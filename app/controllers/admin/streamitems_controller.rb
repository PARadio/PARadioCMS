class Admin::StreamitemsController < ApplicationController
  before_action :require_login
  layout 'main'
  def index

  end

  def showStream
    datestr = params[:year].to_s + "-" + params[:month].to_s + "-" + params[:day].to_s
    @selected_date = Date.strptime(datestr, '%Y-%m-%d')
    @streamitems = Admin::Streamitem.where(date: @selected_date.strftime('%Y-%m-%d')).sorted

    if @streamitems.empty?
      time_taken = 0
    else
      time_taken = TimeDifference.between(Admin::Streamitem.stream_start, @streamitems.last.start_time + @streamitems.last.episode.duration.seconds).in_seconds
    end
    total_time = TimeDifference.between(Admin::Streamitem.stream_start, Admin::Streamitem.stream_end).in_seconds
    @percent_left = ((time_taken / total_time) * 100).round(2)

    if @percent_left >= 90
      @progess_class = 'danger'
    elsif @percent_left >= 75
      @progess_class = 'warning'
    else
      @progess_class = 'success'
    end

    if @streamitems.empty?
      time_available_hrs = TimeDifference.between(Admin::Streamitem.stream_start, Admin::Streamitem.stream_end).in_hours
    else
      time_available_hrs = TimeDifference.between(@streamitems.last.start_time + @streamitems.last.episode.duration.seconds, Admin::Streamitem.stream_end).in_hours
    end
    time_available_min = ("0." + time_available_hrs.to_s.split('.').last).to_f * 60
    time_available_sec = ("0." + time_available_min.to_s.split('.').last).to_f * 60
    @time_available_str = time_available_hrs.to_i.to_s + "h " + time_available_min.to_i.to_s + "m " + time_available_sec.to_i.to_s + "s"

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

    if @newStreamitem.start_time + @newStreamitem.episode.duration.seconds > Admin::Streamitem.stream_end
      time_available_hrs = TimeDifference.between(@streamitems.last.start_time + @streamitems.last.episode.duration.seconds, Admin::Streamitem.stream_end).in_hours
      time_available_min = ("0." + time_available_hrs.to_s.split('.').last).to_f * 60
      time_available_sec = ("0." + time_available_min.to_s.split('.').last).to_f * 60
      time_available_str = time_available_hrs.to_i.to_s + "h " + time_available_min.to_i.to_s + "m " + time_available_sec.to_i.to_s + "s"
      redirect_to(streamitems_show_path(:year => @newStreamitem.date.strftime('%Y'), :month => @newStreamitem.date.strftime('%m'), :day => @newStreamitem.date.strftime('%d')), notice: "Not enough room in schedule for episode. Time Available: " + time_available_str)
    elsif @newStreamitem.save
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
    itemsToShift = Admin::Streamitem.where(date: @streamitem.date.strftime('%Y-%m-%d')).where("position > :positionToDelete", {positionToDelete: @streamitem.position}).sorted

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

    redirect_to(streamitems_show_path(:year => @streamitem.date.strftime('%Y'), :month => @streamitem.date.strftime('%m'), :day => @streamitem.date.strftime('%d')), notice:  "The episode has been removed.")
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
