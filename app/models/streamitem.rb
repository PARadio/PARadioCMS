class Streamitem < ActiveRecord::Base
  belongs_to :episode #holds episode_id

  scope :sorted, lambda { order("position ASC") }

  def start_time
    position = read_attribute(:position)
    if position == 1
      return Livestream::Config.start_time
    else
      date = read_attribute(:date)
      itemsBefore = Streamitem.where(date: date).where("position < :currentPosition", {currentPosition: position}).sorted
      time_counter = Livestream::Config.start_time
      itemsBefore.each do |item|
        time_counter = time_counter + item.episode.duration.seconds;
      end
      return time_counter
    end
  end
end
