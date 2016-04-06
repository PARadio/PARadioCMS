class AddAttachmentColumnToMediaFiles < ActiveRecord::Migration
  def change
    add_column :media_files, :attachment, :string
  end
end
