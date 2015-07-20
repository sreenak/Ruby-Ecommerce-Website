class DiscountCoupon < ActiveRecord::Base
  APPLIES_AS = %w(Fixed Percent)
  STATUSES = %w(Inactive Active)
  enum applies_as: APPLIES_AS

  validates_presence_of :code, :amount, :applies_as
  monetize :minimum_order_price_paisas, with_model_currency: :currency
end
