class FixStreamitemEpisodeRelationship < ActiveRecord::Migration
  def up
    add_index :streamitems, :episode_id
  end
  def down
    remove_index :streamitems, :episode_id
  end
end
