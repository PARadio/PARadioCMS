class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.string "title"    # title of image
      t.integer "user_id" # id of user who posted image
      t.string "ref_link" # link to image file

      t.timestamps null: false
    end

    add_index("images","user_id")
    add_index("images", "ref_link")
  end
  def down
    drop_table :images
  end
end
