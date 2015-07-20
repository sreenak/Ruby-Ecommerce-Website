class CreateJoinTablePartGroupsFabricColors < ActiveRecord::Migration
  def change
    create_join_table :parts_groups, :fabric_colors do |t|
      t.index [:part_group_id, :fabric_color_id], name: 'part_groups_fabric_colors'
      # t.index [:fabric_color_id, :part_group_id]
    end
  end
end
