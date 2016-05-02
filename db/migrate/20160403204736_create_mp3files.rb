class CreateMp3files < ActiveRecord::Migration
  def change
    create_table :mp3files do |t|
      t.string :name
      t.string :attachment

      t.timestamps null: false
    end
  end
end
