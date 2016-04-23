class Admin::Streamitem < ActiveRecord::Base
  belongs_to :episode #holds episode_id
  scope :sorted, lambda { order("streamitems.start_time ASC") }
end
