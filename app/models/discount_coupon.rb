class DiscountCoupon < ActiveRecord::Base
  APPLIES_AS = %w(Fixed Percent)
  enum applies_as: APPLIES_AS

  validates_presence_of :code, :amount, :applies_as
  monetize :minimum_order_price_paisas, with_model_currency: :currency

  def valid_coupon?
    active? and (maximum_usages == nil or maximum_usages > usage_count)
  end
end
