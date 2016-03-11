class CreatePages < ActiveRecord::Migration
  # [str] name, [int] permalink, [int] position, [bool] visible
  def up
    create_table :pages do |t|
      t.integer "subject_id"

      t.string "name"
      t.integer "permalink"
      t.integer "position"
      t.boolean "visible", :default=>false

      t.timestamps null: false
    end
    # indexing helps find these faster. things we need to look up often go here
    add_index("pages", "subject_id")
    add_index("pages", "permalink")
  end

  def down
    remove_index("pages","permalink")
    remove_index("pages","subject_id")
    drop_table :pages
  end
end
