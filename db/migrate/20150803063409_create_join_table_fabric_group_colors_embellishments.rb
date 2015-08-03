class CreateJoinTableFabricGroupColorsEmbellishments < ActiveRecord::Migration
  def change
    create_join_table :fabric_group_colors, :embellishments do |t|
      # t.index [:fabric_group_color_id, :embellishment_id]
      # t.index [:embellishment_id, :fabric_group_color_id]
    end
  end
end
