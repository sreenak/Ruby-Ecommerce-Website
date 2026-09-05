class ChangeForeignKeyInOrder < ActiveRecord::Migration
  def up
    remove_foreign_key :order_statuses, :orders
    add_foreign_key :order_statuses, :orders, on_delete: :cascade
    remove_foreign_key :line_items, :orders
    add_foreign_key :line_items, :orders, on_delete: :cascade
    remove_foreign_key :product_line_item_options, :line_items
    add_foreign_key :product_line_item_options, :line_items, on_delete: :cascade
  end
  def down
    remove_foreign_key :order_statuses, :orders
    add_foreign_key :order_statuses, :orders
    remove_foreign_key :line_items, :orders
    add_foreign_key :line_items, :orders
    remove_foreign_key :product_line_item_options, :line_items
    add_foreign_key :product_line_item_options, :line_items
  end
end
