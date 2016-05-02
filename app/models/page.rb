class Page < ActiveRecord::Base

  belongs_to :subject
  

  scope :sorted, lambda {order("pages.position ASC")}
end
