class Cart
  attr_accessor :order
  attr_accessor :currency

  delegate :id, :line_items, :product_items, :discount_items, :gift_card_usage_items, :total, to: :order

  def initialize(user_id = nil, order_id = nil, currency = 'INR')
    if user_id.present?
      @order = Order.find_or_initialize_by user_id: user_id, status: 'In Cart'
    elsif order_id.present?
      @order = Order.where(id: order_id, status: 'In Cart').first_or_initialize(id: nil)
    else
      @order = Order.new currency: currency
    end
    @currency = currency
    if @order.total.currency != currency
      convert currency
    end
  end

  def add_item(item, price, title, quantity = 1)
    @order.save # Save self before adding the dress
    Rails.logger.info 'price' +price.to_s
    # exit
    amount = price.to_money(@currency)
    # Ugly hack to protect currency on conversion
    if ['Dress', 'GiftCard','EGiftCard','PGiftCard'].include? item.class.name
      original_amount = price.to_money(@currency).exchange_to('INR').fractional
    else
      original_amount = item.price.to_s * 100
    end

    Rails.logger.info amount
    Rails.logger.info original_amount
    line_item = @order.line_items.create(line_itemable: item, amount: amount, original_amount: original_amount, title: title, quantity: quantity)
    calculate
    line_item
  end

  def apply_discount(code)
    discount = DiscountCoupon.find_by_code code
    return 'Invalid coupon!' unless discount.present? and discount.valid_coupon?
    return 'Discount already applied!' if @order.discount_items.present?
    total = product_items.reduce(0) { |sum, p| sum + p.subtotal } # Only take products into account
    if discount.applies_as == 'Percent'
      amount = discount.amount/100 * total
    else
      amount = discount.amount.to_money('INR') > total ? total : discount.amount.to_money('INR').exchange_to(@currency)
    end
    return 'Discount not applicable!' if amount <= 0 || total < discount.minimum_order_price.to_money('INR').exchange_to(@currency)
    add_item(discount, -(amount), "Discount: #{discount.code}")
    'Discount applied.'
  end

  def apply_gift_card(code)
    gift = GiftCard.find_by_code code
    return false unless gift.present? && gift.valid_card?
    available_amount = gift.available_amount.exchange_to(@currency)
    amount = available_amount > @order.total ? @order.total : available_amount
    return false if amount <= 0
    gift_usage = GiftCardUsage.create gift_card_id: gift.id, amount: amount
    item = add_item(gift_usage, -amount, "Gift Card: #{gift.code}")
    gift.update(remaining: gift.remaining - amount)
    calculate
    item
  end

  def update_quantity(items)
    items.each do |(item_id, quantity)|
      next if quantity.to_i < 1
      item = product_items.find item_id
      next unless item.present?
      item.update quantity: quantity.to_i
    end
    calculate
  end

  def update_size(items)
    items.each do |(item_id, standard_size_id)|
      item = line_items.find item_id
      next unless item.product_line_item_option.present?
      item.product_line_item_option.update standard_size_id: standard_size_id.to_i
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
    # if @order.shipping_address.present? && @order.shipping_quote.blank? && @order.shipping_address.country != 'IN'
    #   shipping_service = ShippingService.first
    #   @order.line_items.create(line_itemable: shipping_service, amount: 20.to_money('USD').exchange_to(@currency), quantity: 1, title: 'Shipping Outside India')
    #   calculate
    # end
  end

  def convert(to = 'USD')
    line_items.each do |item|
      price = Money.new(item.original_amount, 'INR').exchange_to(to)
      item.update amount: price
    end
    calculate
  end

  def calculate
    # Rails.logger.info total.inspect
    # First, let's calculate all the discounts
    # Rails.logger.info 'test' + @currency.to_s
    # exit
    discount_items.each do |d|
      discount = d.line_itemable
      unless discount.present?
        d.destroy # Remove discounts which are not present anymore
        next
      end
      total = product_items.reduce(0) { |sum, p| sum + p.subtotal } # Only take products into account
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
    gift_card_usage_items.each do |gu|
      gift = gu.line_itemable.gift_card
      unless gift.present?
        gu.destroy # Remove gift cards which are not present anymore
        next
      end
      total = product_items.reduce(0) { |sum, p| sum + p.subtotal } # Only take products into account
      if gu.amount > @order.total # You can only use upto order limit
        gift.update(remaining: gift.remaining + (gu.amount - @order.total)) # Transfer the balance back
        gu.update(amount: @order.total)
        gu.line_itemable.update(amount: @order.total)
      end
    end
    @order.calculate_total
  end
end