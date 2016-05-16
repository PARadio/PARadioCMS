class MoveUsersToShowFromEpisode < ActiveRecord::Migration
  def up
    remove_column :episodes, :user_id
  end
  def down
    add_column :episodes, :user_id, :integer
    add_index :episodes, :user_id
  end
end
