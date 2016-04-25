class Admin::Streamitem < ActiveRecord::Base
  belongs_to :episode #holds episode_id

  @@stream_start = Time.parse("08:00 PM")
  @@stream_end = Time.parse("11:00 PM")
  cattr_reader :stream_start
  cattr_reader :stream_end

  scope :sorted, lambda { order("position ASC") }

  scope :getCurrent, lambda {
    streamitems = Admin::Streamitem.where(date: Date.today.strftime('%Y-%m-%d')).sorted
    if streamitems.empty? || streamitems.nil?
      return nil
    end

    time_offset = 0;
    currentItem = nil;
    3.times do |i|
      j = 0
      total_seconds = 0;
      streamitems.each do |streamitem|
        total_seconds = total_seconds + streamitem.episode.duration
        if Time.now == (streamitem.start_time + time_offset.seconds)
          currentItem =  streamitem
          break
        elsif Time.now > (streamitem.start_time + time_offset.seconds) && Time.now < ((streamitems[i].start_time + streamitems[i].episode.duration.seconds) + time_offset.seconds)
          currentItem = streamitem
          break
        elsif streamitems[j+1].nil?
          time_offset = time_offset + total_seconds
        end
        j = j + 1
      end
    end

    return currentItem
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
