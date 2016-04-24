class RenameUserLevelToAccessLevel < ActiveRecord::Migration
  def up
    rename_column :users, :user_level, :access_level
  end

  def down
    rename_column :users, :access_level, :user_level
  end
end
