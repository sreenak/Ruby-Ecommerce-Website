class Order < ActiveRecord::Base
  STATUSES = ['In Cart', 'Paid', 'Completed', 'Cancelled', 'Returned']

  belongs_to :user
  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :dress_items, -> { where line_itemable_type: 'Dress' }, class_name: 'LineItem'
  has_many :gift_card_items, -> { where line_itemable_type: 'GiftCard' }, class_name: 'LineItem'
  has_many :product_items, -> { where line_itemable_type: %w(Dress GiftCard Product) }, class_name: 'LineItem'
  has_many :discount_items, -> { where line_itemable_type: 'DiscountCoupon' }, class_name: 'LineItem'
  has_one :shipping_quote, -> { where line_itemable_type: 'ShippingService' }, class_name: 'LineItem'
  has_many :gift_card_usage_items, -> { where line_itemable_type: 'GiftCardUsage' }, class_name: 'LineItem'
  has_many :dresses, through: :line_items, source: :line_itemable, source_type: 'Dress'
  has_many :gift_cards, through: :line_items, source: :line_itemable, source_type: 'GiftCard'
  has_many :gift_card_usages, through: :line_items, source: :line_itemable, source_type: 'GiftCardUsage'
  has_many :shipments, dependent: :destroy
  has_one :payment, dependent: :destroy

  monetize :total_paisas, with_model_currency: :currency

  enum status: STATUSES

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address

  scope :valid_orders, -> { where.not(status: 'In Cart', user_id: nil) }

  def merge_orders user_id
    in_cart_orders = Order.where(user_id: user_id, status: 'In Cart')
    if in_cart_orders.size > 1
      in_cart_orders.each do |o|
        o.line_items.each do |l|
          l.update order_id: id
        end
        o.destroy unless o.id == self.id
      end
      calculate_total
    end
  end

  def calculate_total
    total_amount = line_items.reduce(0) { |amount, item| amount + item.subtotal }
    update(total: total_amount)
  end
end
