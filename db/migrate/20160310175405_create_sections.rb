class CreateSections < ActiveRecord::Migration
  # [str] name, [int] position, [bool] visible, [str] content_type, [text] content
  def up
    create_table :sections do |t|
      t.integer "page_id"

      t.string "name"
      t.integer "position"
      t.boolean "visible", :default=>false
      t.string "content_type"
      t.text "content"

      t.timestamps null: false
    end

    add_index("sections","page_id")
  end

  def down
    remove_index("sections", "page_id")
    drop_table :sections
  end
end
