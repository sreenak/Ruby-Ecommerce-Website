class CreateJoinTableProductsStandardSizes < ActiveRecord::Migration
  def change
    create_join_table :products, :standard_sizes do |t|
      # t.index [:product_id, :standard_sizes_id]
      # t.index [:standard_sizes_id, :product_id]
    end
  end
end
