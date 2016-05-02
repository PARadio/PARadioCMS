class ApiController < ApplicationController
  def getStreamMetadata
    datestr = params[:year].to_s + "-" + params[:month].to_s + "-" + params[:day].to_s
    @selected_date = Date.strptime(datestr, '%Y-%m-%d')
    @streamitems = Admin::Streamitem.where(date: @selected_date.strftime('%Y-%m-%d')).sorted

    if @streamitems.empty?
      @time_taken = 0
    else
      @time_taken = TimeDifference.between(Admin::Streamitem.stream_start, @streamitems.last.start_time + @streamitems.last.episode.duration.seconds).in_seconds
    end
    @total_time = TimeDifference.between(Admin::Streamitem.stream_start, Admin::Streamitem.stream_end).in_seconds
    @percent_taken = ((@time_taken / @total_time) * 100).round(2)

    if @streamitems.empty?
      @time_available_hrs = TimeDifference.between(Admin::Streamitem.stream_start, Admin::Streamitem.stream_end).in_hours
    else
      @time_available_hrs = TimeDifference.between(@streamitems.last.start_time + @streamitems.last.episode.duration.seconds, Admin::Streamitem.stream_end).in_hours
    end
    @time_available_min = ("0." + @time_available_hrs.to_s.split('.').last).to_f * 60
    @time_available_sec = ("0." + @time_available_min.to_s.split('.').last).to_f * 60
    @time_available_str = @time_available_hrs.to_i.to_s + "h " + @time_available_min.to_i.to_s + "m " + @time_available_sec.to_i.to_s + "s"

    render "api/get/stream/metadata", layout: false
  end

  def getCurrentItem
    @currentItem = Admin::Streamitem.getCurrent

    render "api/get/stream/current", layout: false
  end

  def getStreamItems
    datestr = params[:year].to_s + "-" + params[:month].to_s + "-" + params[:day].to_s
    @selected_date = Date.strptime(datestr, '%Y-%m-%d')
    @streamitems = Admin::Streamitem.where(date: @selected_date.strftime('%Y-%m-%d')).sorted

    render "api/get/stream/items", layout: false
  end
end
