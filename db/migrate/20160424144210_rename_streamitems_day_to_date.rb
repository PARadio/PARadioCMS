class RenameStreamitemsDayToDate < ActiveRecord::Migration
  def up
    rename_column :streamitems, :day, :date
  end

  def down
    rename_column :streamitems, :date, :day
  end
end
