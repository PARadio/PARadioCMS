class MoveDurationToEpisode < ActiveRecord::Migration
  def up
    remove_column :mediafiles, :duration
    add_column :episodes, :duration, :integer
  end

  def down
    add_column :mediafiles, :duration, :integer
    remove_column :episodes, :duration
  end
end
