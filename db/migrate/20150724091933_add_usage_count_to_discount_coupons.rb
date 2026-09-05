class AddUsageCountToDiscountCoupons < ActiveRecord::Migration
  def change
    add_column :discount_coupons, :usage_count, :integer, default: 0, null: false
  end
end
