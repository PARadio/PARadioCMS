class Admin::Streamitem < ActiveRecord::Base
  belongs_to :episode #holds episode_id

  @@stream_start = Time.parse("05:00 AM")
  @@stream_end = Time.parse("11:00 PM")
  cattr_reader :stream_start
  cattr_reader :stream_end

  scope :sorted, lambda { order("position ASC") }

  scope :getCurrent, lambda {
    streamitems = Admin::Streamitem.where(date: Date.today.strftime('%Y-%m-%d')).sorted
    if streamitems.empty? || streamitems.nil?
      #
      # VERY NOT GOOD FIX THIS
      #
      return Admin::Streamitem.first
    end
    i = 0
    streamitems.each do |streamitem|
      if Time.now == streamitem.start_time
        return streamitem
      elsif i+1 >= streamitems.length
        #
        # VERY NOT GOOD FIX THIS
        # FIND WHAT WOULD BE PLAYING IF PLAYLIST LOOPED
        #
        return Admin::Streamitem.first
      elsif Time.now > streamitem.start_time && Time.now < streamitems[i+1].start_time
        return streamitem
      end
      i = i + 1
    end
  }

  scope :dank, lambda {
    puts 'dank'
    return 'dank'
  }

  def start_time
    position = read_attribute(:position)
    if position == 1
      return Admin::Streamitem.stream_start
    else
      date = read_attribute(:date)
      itemsBefore = Admin::Streamitem.where(date: date).where("position < :currentPosition", {currentPosition: position}).sorted
      time_counter = Admin::Streamitem.stream_start
      itemsBefore.each do |item|
        time_counter = time_counter + item.episode.duration.seconds;
      end
      return time_counter
    end
  end
end
