class Admin::Streamitem < ActiveRecord::Base
  belongs_to :episode #holds episode_id
  scope :sorted, lambda { order("streamitems.start_time ASC") }

  scope :getCurrent, lambda {
    if Admin::Streamitem.count == 0
      return false
    end
    streamitems = Admin::Streamitem.sorted
    i = 0
    streamitems.each do |streamitem|
      if Time.now == streamitem.start_time
        return streamitem
      elsif i+1 >= streamitems.length
        return streamitem
      elsif Time.now > streamitem.start_time && Time.now < streamitems[i+1].start_time
        return streamitem
      end
      i = i + 1
    end
  }
end
