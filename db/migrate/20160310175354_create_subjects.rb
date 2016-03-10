class CreateSubjects < ActiveRecord::Migration
  # [str] name, [int] position, [bool] visible
  # add foreign keys
  # add 3 indexes (index all foreign keys!)

  # subject has pages. pages have sections

  def up
    create_table :subjects do |t|
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default=>false

      t.timestamps null: false
    end
  end

  def down
    drop_table :subjects
end
