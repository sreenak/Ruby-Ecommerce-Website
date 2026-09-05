class CreateJoinTableProductsColors < ActiveRecord::Migration
  def change
    create_join_table :products, :colors do |t|
      # t.index [:product_id, :color_id]
      # t.index [:color_id, :product_id]
    end
  end
end
