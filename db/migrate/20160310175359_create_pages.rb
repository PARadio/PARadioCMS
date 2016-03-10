class CreatePages < ActiveRecord::Migration
  # [str] name, [int] permalink, [int] position, [bool] visible
  def up
    create_table :pages do |t|
      t.integer "subject_id"

      t.string "name"
      t.int "permalink"
      t.integer "position"
      t.boolean "visible", :default=>false

      t.timestamps null: false
    end
    add_index("pages", "subject_id")
    add_index("pages", "permalink")
  end

  def down
    drop_table :pages
end
