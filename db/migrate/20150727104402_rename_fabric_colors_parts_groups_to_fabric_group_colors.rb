class RenameFabricColorsPartsGroupsToFabricGroupColors < ActiveRecord::Migration
  def self.up
    rename_table :fabric_colors_parts_groups, :fabric_group_colors
  end
  def self.down
    rename_table :fabric_group_colors, :fabric_colors_parts_groups
  end
end
