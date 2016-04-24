class ChangeStreamitemStartTimeToDayAndPosition < ActiveRecord::Migration
  def up
    remove_column :streamitems, :start_time
    add_column :streamitems, :day, :date
    add_column :streamitems, :position, :integer
  end

  def down
    remove_column :streamitems, :day
    remove_column :streamitems, :position
    add_column :streamitems, :start_time, :datetime
  end
end
