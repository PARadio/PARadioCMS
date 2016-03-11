class CreateMediaFiles < ActiveRecord::Migration
  def up
    create_table :media_files do |t|
      t.string "title"    # title of image
      t.integer "user_id" # id of user who posted image
      t.string "ref_link" # link to image file
      t.integer "length"  # length of media file

      t.timestamps null: false
    end

    add_index("media_files", "user_id")
    add_index("media_files","ref_link")
  end
  def down
    remove_index("media_files","ref_link")
    remove_index("media_files" , "user_id")
    drop_table :media_files
  end
end
