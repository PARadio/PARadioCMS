class CreateShows < ActiveRecord::Migration
  def up
    create_table :shows do |t|
      t.integer "user_id"  # id of show creator
      t.string "name"      # name of show
      t.text "description" # description of show
      t.integer "stage"    # 0- in creation, 1- in editing, 2- deployed
      t.integer "image_id" # foreign key of associated thumbnail in images

      t.timestamps null: false
    end

    add_index("shows", "user_id")
    add_index("shows", "name")
    add_index("shows", "image_id")
  end

  def down
    remove_index("shows", "image_id")
    remove_index("shows", "name")
    remove_index("shows", "user_id")
    drop_table :shows
  end
end
