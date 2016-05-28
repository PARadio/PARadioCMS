class Api::ApiController < ApplicationController
  def getStreamMetadata
    datestr = params[:year].to_s + "-" + params[:month].to_s + "-" + params[:day].to_s
    @selected_date = Date.strptime(datestr, '%Y-%m-%d')

    @time_taken = Livestream::Stats.time_taken_sec(@selected_date)
    @total_time = Livestream::Stats.total_time_sec(@selected_date)
    @percent_taken = Livestream::Stats.percent_taken(@selected_date)

    @time_available_obj = Livestream::Stats.time_available_obj(@selected_date)

    @stream_start = Livestream::Config.start_time(@selected_date).strftime("%I:%M%p")
    @stream_end   = Livestream::Config.end_time(@selected_date).strftime("%I:%M%p")

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
