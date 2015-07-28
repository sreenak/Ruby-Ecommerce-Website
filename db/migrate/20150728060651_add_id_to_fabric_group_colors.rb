class AddIdToFabricGroupColors < ActiveRecord::Migration
  def change
    add_column :fabric_group_colors, :id, :primary_key
  end
end
