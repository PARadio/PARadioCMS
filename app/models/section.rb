class Section < ActiveRecord::Base
  scope :sorted, lambda { order("sections.position ASC") }

  has_many :section_edits


end
