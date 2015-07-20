class AddCurrencyToDiscountCoupons < ActiveRecord::Migration
  def change
    add_column :discount_coupons, :currency, :string, default: 'INR', null: false
  end
end
