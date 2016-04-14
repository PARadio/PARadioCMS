class Episode < ActiveRecord::Base
  has_one :streamitem, dependent: :destroy
  #has one means Episode is linked to from :streamitem. Episode doesn't even
  #know it has one based off of db stuff.
  has_one :mediafile, dependent: :destroy, autosave: true

end
