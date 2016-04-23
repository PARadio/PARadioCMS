class AddSteamitemScheduling < ActiveRecord::Migration
  def up
    remove_column :streamitems, :position
    add_column :streamitems, :start_time, :datetime
  end

  def down
    remove_column :streamitems, :start_time
    add_column :streamitems, :position, :integer
  end
end
