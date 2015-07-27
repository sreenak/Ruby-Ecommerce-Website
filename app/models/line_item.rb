class LineItem < ActiveRecord::Base
  has_one :product_line_item_option, dependent: :destroy
  belongs_to :order
  belongs_to :line_itemable, polymorphic: true
  belongs_to :discount_coupon, polymorphic: true, foreign_key: 'line_itemable_id', foreign_type: 'line_itemable_type', class_name: 'DiscountCoupon', counter_cache: :usage_count

  belongs_to :shipping
  has_one :shipping_address, through: :shipping, dependent: :destroy
  has_one :customised_dress_order_item
  monetize :amount_paisas, with_model_currency: :currency

  scope :products, -> { where(line_itemable_type: 'Product') }
  scope :dresses, -> { where(line_itemable_type: 'Dress') }
  scope :gift_cards, -> { where(line_itemable_type: 'GiftCard') }
  scope :discounts, -> { where(line_itemable_type: 'DiscountCoupon') }

  def subtotal
    amount * quantity
  end
end
