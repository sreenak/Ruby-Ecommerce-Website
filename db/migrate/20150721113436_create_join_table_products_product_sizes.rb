class CreateJoinTableProductsProductSizes < ActiveRecord::Migration
  def change
      create_join_table :products, :product_sizes do |t|
      # t.index [:product_id, :product_sizes_id]
      # t.index [:product_sizes_id, :product_id]
    end
  end
end
