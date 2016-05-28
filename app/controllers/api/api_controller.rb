class Api::ApiController < ApplicationController
  def getStreamMetadata
    datestr = params[:year].to_s + "-" + params[:month].to_s + "-" + params[:day].to_s
    @selected_date = Date.strptime(datestr, '%Y-%m-%d')
    @streamitems = Streamitem.where(date: @selected_date.strftime('%Y-%m-%d')).sorted

    if @streamitems.empty?
      @time_taken = 0
    else
      @time_taken = TimeDifference.between(Livestream::Engine.start_time, @streamitems.last.start_time + @streamitems.last.episode.duration.seconds).in_seconds
    end
    @total_time = TimeDifference.between(Livestream::Engine.start_time, Livestream::Engine.end_time).in_seconds
    @percent_taken = ((@time_taken / @total_time) * 100).round(2)

    if @streamitems.empty?
      @time_available_hrs = TimeDifference.between(Livestream::Engine.start_time, Livestream::Engine.end_time).in_hours
    else
      @time_available_hrs = TimeDifference.between(@streamitems.last.start_time + @streamitems.last.episode.duration.seconds, Livestream::Engine.end_time).in_hours
    end
    @time_available_min = ("0." + @time_available_hrs.to_s.split('.').last).to_f * 60
    @time_available_sec = ("0." + @time_available_min.to_s.split('.').last).to_f * 60
    @time_available_str = @time_available_hrs.to_i.to_s + "h " + @time_available_min.to_i.to_s + "m " + @time_available_sec.to_i.to_s + "s"

    @stream_start = Livestream::Engine.start_time.strftime("%I:%M%p")
    @stream_end   = Livestream::Engine.end_time.strftime("%I:%M%p")

    render "api/get/stream/metadata", layout: false
  end

  def getCurrentItem
    @currentItem = Livestream::Engine.getCurrent

    render "api/get/stream/current", layout: false
  end

  def getStreamItems
    datestr = params[:year].to_s + "-" + params[:month].to_s + "-" + params[:day].to_s
    @selected_date = Date.strptime(datestr, '%Y-%m-%d')
    @streamitems = Streamitem.where(date: @selected_date.strftime('%Y-%m-%d')).sorted

    render "api/get/stream/items", layout: false
  end
end
