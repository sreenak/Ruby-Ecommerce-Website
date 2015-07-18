class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :line_itemable, polymorphic: true
  belongs_to :shipping
  has_one :shipping_address, through: :shipping
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
