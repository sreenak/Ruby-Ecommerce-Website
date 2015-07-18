class DiscountCoupon < ActiveRecord::Base
  APPLIES_AS = %w(Fixed Percent)
  enum applies_as: APPLIES_AS

  validates_presence_of :code, :amount, :applies_as
end
