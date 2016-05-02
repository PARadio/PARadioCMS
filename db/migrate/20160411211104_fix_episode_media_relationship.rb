class FixEpisodeMediaRelationship < ActiveRecord::Migration
  def up
    remove_column :episodes, :media_id
    add_column :mediafiles, :episode_id, :integer
    add_index :mediafiles, :episode_id
  end
  def down
    remove_column :mediafiles, :episode_id
    add_column :episodes, :media_id, :integer
    add_index :episodes, :media_id
  end
end
