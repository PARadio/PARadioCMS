class Episode < ActiveRecord::Base
  has_one :mediafile, dependent: :destroy, autosave: true

end
