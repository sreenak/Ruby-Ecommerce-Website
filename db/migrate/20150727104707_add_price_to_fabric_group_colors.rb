class AddPriceToFabricGroupColors < ActiveRecord::Migration
  def change
    add_money :fabric_group_colors, :price
  end
end
