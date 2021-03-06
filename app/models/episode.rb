class Episode < ActiveRecord::Base

  has_one :streamitem, dependent: :destroy
  #has one means Episode is linked to from :streamitem. Episode doesn't even
  #know it has one based off of db stuff.
  has_one :mediafile, dependent: :destroy, autosave: true
  belongs_to :show, inverse_of: :episodes


  validates :name, :presence => true , :length =>{:maximum => 150}
  validates_presence_of :description
  validates_length_of :description, :maximum => 500
  validates_presence_of :transcript
  validates_length_of :transcript, :maximum => 1000

  def duration_str
    duration_sec = duration
    duration_min = (duration_sec/60).floor
    duration_sec = duration_sec - (duration_min*60)

    duration_hrs = (duration_sec/60).floor

    "#{duration_min}:#{duration_sec}"
  end
end
