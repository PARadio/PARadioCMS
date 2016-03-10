class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|

      # short version of:  t.column "column_name", :TYPE
      t.string "first_name", :limit=>25
      t.string "last_name", :limit=>50
      t.string "email", :default => "", :null =>false
      t.string "password", :limit=>50
    
      t.timestamps null: false
      # t .timestamps automatically adds:
      #   -- t.datetime "created_at"
      #   -- t.datetime "updated_at"
    end
  end

  def down
    drop_table :users
  end

end
