class CreateEpisodes < ActiveRecord::Migration
  def up
    create_table :episodes do |t|

      t.integer "show_id"         # id of parent show
      t.string "name"             # name of episode
      t.text "description"        # description of show
      t.text "transcript"         # transcript for show
      t.string "media_id"         # id of media for show
      t.integer "stage"           # stage of episode-- 1 is only accessible to user, 2 to editors, 3 to world
      t.integer "episode_number"  # the episode number (helps order episodes)

      t.timestamps null: false
    end

    add_index("episodes", "show_id")
    add_index("episodes", "name")
    add_index("episodes", "media_id")
  end

  def down
    remove_index("episodes", "media_id")
    remove_index("episodes", "name")
    remove_index("episodes", "show_id")
    drop_table :episodes
  end
end
