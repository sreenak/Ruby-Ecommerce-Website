class RenameFabricColorsPartsGroupsColumns < ActiveRecord::Migration
  def change
    rename_column :fabric_colors_parts_groups, :part_group_id, :fabric_parts_group_id
  end
end
