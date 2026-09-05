class AddMaterialToProducts < ActiveRecord::Migration
  def change
    add_column :products, :material, :text
  end
end
