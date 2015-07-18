class RenamePartGroupToPartsGroup < ActiveRecord::Migration
  def change
    rename_table :part_groups, :parts_groups
    rename_table :fabric_colors_part_groups, :fabric_colors_parts_groups
    rename_column :parts, :part_group_id, :parts_group_id
  end
end
