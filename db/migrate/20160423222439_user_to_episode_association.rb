class UserToEpisodeAssociation < ActiveRecord::Migration
  def up
    add_column :episodes, :user_id, :integer
    add_index :episodes, :user_id
  end
  def down
    remove_column :episodes, :user_id
  end
end
