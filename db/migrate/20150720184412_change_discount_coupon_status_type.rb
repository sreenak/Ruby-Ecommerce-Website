class ChangeDiscountCouponStatusType < ActiveRecord::Migration
  def up
    change_column :discount_coupons, :status, :boolean, default: 0
  end

  def down
    change_column :discount_coupons, :status, :integer, limit: 2
  end
end
