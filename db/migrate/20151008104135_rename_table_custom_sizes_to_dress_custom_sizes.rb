class RenameTableCustomSizesToDressCustomSizes < ActiveRecord::Migration
  def self.up
    rename_table :custom_sizes, :dress_custom_sizes
  end
  def self.down
    rename_table :dress_custom_sizes, :custom_sizes
  end
end
