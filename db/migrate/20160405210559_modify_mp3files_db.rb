class ModifyMp3filesDb < ActiveRecord::Migration
  def up
    change_table :mp3files do |t|
      t.integer :user_id, :default => 0
      t.integer :duration, :default => 0 #in seconds
    end
  end

  def down
    remove_column :mp3files, :user_id
    remove_column :mp3files, :duration
  end
end
