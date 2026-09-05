class RenameStatusToActiveInDiscountCoupons < ActiveRecord::Migration
  def up
    rename_column :discount_coupons, :status, :active
    change_column :discount_coupons, :active, :boolean
  end
  def down
    rename_column :discount_coupons, :active, :status
    change_column :discount_coupons, :status, :integer, limit: 2
  end
end
