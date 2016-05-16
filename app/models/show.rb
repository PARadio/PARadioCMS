class Show < ActiveRecord::Base
  has_many :episodes, inverse_of: :show 
  belongs_to :user

  validates :name, :presence => true , :length =>{:maximum => 150}
  validates_presence_of :description
  validates_length_of :description, :maximum => 500
end
