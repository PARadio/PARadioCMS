class MediafilesRenameLength < ActiveRecord::Migration
  def up
    rename_column :mediafiles, :length, :duration
  end

  def down
    rename_column :mediafiles, :duration, :length
  end
end
