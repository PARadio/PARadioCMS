class EpisodeNumberFix < ActiveRecord::Migration
  def change
    rename_column :episodes, :episode_number, :number
  end
end
