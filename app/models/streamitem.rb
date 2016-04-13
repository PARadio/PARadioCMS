class Streamitem < ActiveRecord::Base
    scope :sorted, lambda { order("streamitems.position ASC") }
end
