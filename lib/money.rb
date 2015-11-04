class Money
  alias :old_exchange_to :exchange_to

  def exchange_to(other_currency, &rounding_method)
    value = old_exchange_to(other_currency, &rounding_method)
    Rails.logger.info 'Value: ' + value.to_s
    Money.new(((value.to_d/100).ceil) * 100, other_currency)
  end
end