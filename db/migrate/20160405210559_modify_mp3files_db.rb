class ModifyMp3filesDb < ActiveRecord::Migration
  def up
    change_table :mp3files do |t|
      t.integer :user_id
      t.integer :duration
    end
    Mp3files.update_all ["user_id = ?", 0]
    Mp3files.update_all ["duration = ?", 0]
  end

  def down
    remove_column :mp3files, :user_id
    remove_column :mp3files, :duration
  end
end
