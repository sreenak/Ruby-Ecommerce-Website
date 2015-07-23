class CreateProductLineItemOptions < ActiveRecord::Migration
  def change
    create_table :product_line_item_options do |t|
      t.belongs_to :line_item, index: true, foreign_key: true
      t.belongs_to :standard_size, index: true, foreign_key: true
      t.boolean :is_gift, default: 0, null: false
      t.string :message
      t.timestamps null: false
    end
  end
end
