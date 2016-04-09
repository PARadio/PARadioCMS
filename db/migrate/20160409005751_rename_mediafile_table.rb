class RenameMediafileTable < ActiveRecord::Migration
  def change
    rename_table :media_files, :mediafiles
  end
end
