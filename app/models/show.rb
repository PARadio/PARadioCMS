class Show < ActiveRecord::Base
  has_many :episodes
  belongs_to :user, :class_name=>"User", :foreign_key=>"user_id"

  validates :name, :presence => true , :length =>{:maximum => 150}
  validates_presence_of :description
  validates_length_of :description, :maximum => 500
end
