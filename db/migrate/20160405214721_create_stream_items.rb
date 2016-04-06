class CreateStreamItems < ActiveRecord::Migration
  def up
    create_table :stream_items do |t|
      t.string :episode_id
      t.integer :position

      t.timestamps null: false
    end
  end

  def down
    drop_table :stream_items
  end
end
