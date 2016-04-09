class RenameStreamitemsTable < ActiveRecord::Migration
  def change
    rename_table :stream_items, :streamitems
  end
end
