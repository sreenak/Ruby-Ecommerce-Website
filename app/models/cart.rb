class Cart
  attr_accessor :order
  attr_accessor :currency

  def initialize(user_id = nil, order_id = nil, currency = 'INR')
    if order_id.present?
      @order = Order.find_or_initialize_by id: order_id, status: 'In Cart'
    elsif user_id.present?
      @order = Order.find_or_initialize_by user_id: user_id, status: 'In Cart'
    else
      @order = Order.new currency: currency
    end
    if @order.total.currency != currency
      convert currency
    end
    @currency = currency
  end

  def add_dress(id, price = 0, quantity = 1)
    product = Dress.find id
    return false unless product.present?
    @order.save # Save self before adding the dress
    line_item = @order.line_items.create(line_itemable_type: 'Dress', line_itemable_id: product.id, amount: price.to_money(@currency), title: product.name, quantity: quantity)
    calculate
    line_item
  end

  def add_product(id, quantity = 1)
    product = Product.find id
    # size = ProductSize.find id
    # color = Color.find id
    return false unless product.present?
    @order.save # Save self before adding the dress
    line_item = @order.line_items.create(line_itemable_type: 'Product', line_itemable_id: product.id, amount: product.price.exchange_to(@currency), title: product.name, quantity: quantity)
    calculate
    line_item
  end

  # Ordered by is existing user id, ordering for is the email id
  def add_gift_card(gift)
    @order.save # Save order before adding the gift card
    item = @order.line_items.create(line_itemable_type: 'GiftCard', line_itemable_id: gift.id, amount: gift.amount.exchange_to(@currency), quantity: 1, title: 'Gift Voucher')
    calculate
    item
  end

  def apply_discount(code)
    discount = DiscountCoupon.find_by_code code
    return 'Invalid coupon!' unless discount.present? and discount.valid_coupon?
    return 'Discount already applied!' if @order.discount_items.present?
    total = @order.product_items.reduce(0) { |sum, p| sum + p.subtotal } # Only take products into account
    if discount.applies_as == 'Percent'
      amount = discount.amount/100 * total
    else
      amount = discount.amount.to_money('INR') > total ? total : discount.amount.to_money('INR').exchange_to(@currency)
    end
    return 'Discount not applicable!' if amount <= 0 || total < discount.minimum_order_price.to_money('INR').exchange_to(@currency)
    item = @order.line_items.create(discount_coupon: discount, amount: -(amount), quantity: 1, title: "Discount: #{discount.code}")
    @order.calculate_total
    'Discount applied.'
  end

  def apply_gift_card(code)
    gift = GiftCard.find_by_code code
    return false unless gift.present? && gift.valid_card?
    available_amount = gift.available_amount.exchange_to(@currency)
    amount = available_amount > @order.total ? @order.total : available_amount
    return false if amount <= 0
    gift_usage = GiftCardUsage.create gift_card_id: gift.id, amount: amount
    item = @order.line_items.create(line_itemable_type: 'GiftCardUsage', line_itemable_id: gift_usage.id, amount: -amount, quantity: 1, title: "Gift Card: #{gift.code}")
    gift.update(remaining: gift.remaining - amount)
    calculate
    item
  end

  def update_quantity(items)
    items.each do |(item_id, quantity)|
      next if quantity.to_i < 1
      item = @order.product_items.find item_id
      next unless item.present?
      item.update quantity: quantity.to_i
    end
    calculate
  end

  def remove_item id
    item = LineItem.find id
    if @order.line_items.include? item
      item.destroy
      if %w(GiftCard GiftCardUsage).include? item.line_itemable_type
        item.line_itemable.destroy
      end
      calculate
    end
  end

  def calculate_shipping
    if @order.shipping_address.present? && @order.shipping_quote.blank? && @order.shipping_address.country != 'IN'
      @order.line_items.create(line_itemable_type: 'ShippingService', line_itemable_id: 1, amount: 20.to_money('USD').exchange_to(@currency), quantity: 1, title: 'Shipping Outside India')
      calculate
    end
  end

  def convert(to = 'USD')
    line_items.each do |item|
      price = item.amount.exchange_to(to)
      item.update amount: price
    end
    calculate
  end

  def id
    @order.id
  end

  def line_items
    @order.line_items
  end

  def products
    @order.product_items
  end

  def discounts
    @order.discount_items
  end

  def gifts
    @order.gift_card_usage_items
  end

  def total
    @order.total
  end

  private
  def calculate
    # First, let's calculate all the discounts
    @order.discount_items.each do |d|
      discount = d.line_itemable
      unless discount.present?
        d.destroy # Remove discounts which are not present anymore
        next
      end
      total = @order.product_items.reduce(0) { |sum, p| sum + p.subtotal } # Only take products into account
      if discount.applies_as == 'Percent'
        amount = discount.amount/100 * total
      else
        amount = discount.amount.to_money('INR') > total ? total : discount.amount.to_money('INR').exchange_to(@currency)
      end
      # Let's not keep 0 discounts
      if amount <= 0
        d.destroy
        next
      end
      d.update amount: -amount
    end
    # Then the gift card usages
    @order.gift_card_usage_items.each do |gu|
      gift = gu.line_itemable.gift_card
      unless gift.present?
        gu.destroy # Remove gift cards which are not present anymore
        next
      end
      total = @order.product_items.reduce(0) { |sum, p| sum + p.subtotal } # Only take products into account
      if gu.amount > @order.total # You can only use upto order limit
        gift.update(remaining: gift.remaining + (gu.amount - @order.total)) # Transfer the balance back
        gu.update(amount: @order.total)
        gu.line_itemable.update(amount: @order.total)
      end
    end
    @order.calculate_total
  end
end