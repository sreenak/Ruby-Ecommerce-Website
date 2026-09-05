class CreateDiscountCoupons < ActiveRecord::Migration
  def change
    create_table :discount_coupons do |t|
      t.string :code
      t.decimal :amount, scale: 2, precision: 9, default: 0, null: false
      t.integer :applies_as, default: 0, null: false, limit: 2
      t.integer :maximum_usages
      t.integer :minimum_order_price_paisas, default: 0, null: false
      t.integer :status, default: 0, null: false, limit: 2

      t.timestamps null: false
    end
  end
end
