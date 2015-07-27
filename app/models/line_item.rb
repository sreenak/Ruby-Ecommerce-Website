class LineItem < ActiveRecord::Base
  has_one :product_line_item_option, dependent: :destroy
  belongs_to :order
  belongs_to :line_itemable, polymorphic: true
  belongs_to :shipping

  monetize :amount_paisas, with_model_currency: :currency

  scope :products, -> { where(line_itemable_type: 'Product') }
  scope :dresses, -> { where(line_itemable_type: 'Dress') }
  scope :gift_cards, -> { where(line_itemable_type: 'GiftCard') }
  scope :discounts, -> { where(line_itemable_type: 'DiscountCoupon') }

  after_create :increment_usage
  after_destroy :decrement_usage

  def subtotal
    amount * quantity
  end

  private
  def increment_usage
    line_itemable.update(usage_count: line_itemable.usage_count + 1) if line_itemable_type == 'DiscountCoupon'
  end

  def decrement_usage
    line_itemable.update(usage_count: line_itemable.usage_count - 1) if line_itemable_type == 'DiscountCoupon'
  end
end
