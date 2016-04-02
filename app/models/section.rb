class Section < ActiveRecord::Base
  scope :sorted, lambda { order("sections.position ASC") }

  has_many :section_edits
  has_many :editors, :through=> :section_edits, :class_name => "User"

end
