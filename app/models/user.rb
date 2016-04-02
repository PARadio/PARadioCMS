class User < ActiveRecord::Base
  # to configure with diff table name
  # self.table_name = "different name"
  has_many :section_edits #links to rich table
  has_many :sections, :through=> :section_edits #links to rich table values
  has_and_belongs_to_many :pages
end
