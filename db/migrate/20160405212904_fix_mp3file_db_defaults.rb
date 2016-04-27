class FixMp3fileDbDefaults < ActiveRecord::Migration
  def up
    change_column :mp3files, :user_id, :integer, :null => true
  end

  def down
    change_column :mp3files, :user_id, :integer, :null => false
  end
end
