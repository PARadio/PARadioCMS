class Admin::StreamitemsController < ApplicationController
  before_action :require_login
  layout 'main'
  def index

  end

  def new
    datestr = params[:year].to_s + "-" + params[:month].to_s + "-" + params[:day].to_s
    @selected_date = Date.strptime(datestr, '%Y-%m-%d')
    @streamitem = Streamitem.new
    @episodes = Episode.all
  end

  def create
    # create a new stream item and pass it an episode to add.
    # dynamically assign position variable

    # loop through episode ids to add
    # key refers to the name of the parameter.
    # since the episode_id is echoed in the name field,
    # key refers to the episode_id
    params.each do |key, value|
      if !(key == "date" || key == "utf8" || key == "authenticity_token" || key == "commit" || key == "controller" || key == "action")
        @newStreamitem = Streamitem.new
        @episode = Episode.find(key)
        @newStreamitem.episode_id = key
        @newStreamitem.date = Date.strptime(params[:date][:string], '%Y-%m-%d')
        @newStreamitem.position = get_next_position(@newStreamitem.date)

        if @newStreamitem.start_time + @episode.duration.seconds > Livestream::Config.end_time
          redirect_to(streamitems_show_path(:year => @newStreamitem.date.strftime('%Y'), :month => @newStreamitem.date.strftime('%m'), :day => @newStreamitem.date.strftime('%d')), notice: "Not enough room in schedule for episode. Time Available: " + Livestream::Stats.time_available_str(@newStreamitem.date))
        elsif @newStreamitem.save
          # woo it saved
        else
          render "new"
        end
      end
    end

    redirect_to(streamitems_show_path(:year => @newStreamitem.date.strftime('%Y'), :month => @newStreamitem.date.strftime('%m'), :day => @newStreamitem.date.strftime('%d')), notice: "The stream items have been added.")
  end

  def move
    datestr = params[:year].to_s + "-" + params[:month].to_s + "-" + params[:day].to_s
    i = 1
    itemsArray = [];
    params[:old_positions].each do |old_position|
      itemToShift = Streamitem.where(date: datestr).where(position: old_position).first
      itemToShift.position = i
      itemsArray.push(itemToShift)
      i = i + 1
    end
    itemsArray.each do |item|
      item.save
    end
  end

  def destroy
    @streamitem = Streamitem.find(params[:id]).destroy
    itemsToShift = Streamitem.where(date: @streamitem.date.strftime('%Y-%m-%d')).where("position > :positionToDelete", {positionToDelete: @streamitem.position}).sorted

    # rewrite order
    itemsToShift.each do |item|
      item.position = item.position - 1
      item.save
    end

    redirect_to(streamitems_show_path(:year => @streamitem.date.strftime('%Y'), :month => @streamitem.date.strftime('%m'), :day => @streamitem.date.strftime('%d')), notice:  "The episode has been removed.")
  end

  private
    def streamitems_params
      params.require(:streamitem).permit(:episode_id)
    end

    def get_next_position(selected_date)
      #returns next start time for stream item.
      streamitems = Streamitem.where(date: selected_date.strftime('%Y-%m-%d')).sorted
      if streamitems.empty?
        newPosition = 1
      else
        newPosition = streamitems.last.position + 1
      end
      return newPosition
    end
end
