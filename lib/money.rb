class Money
  alias :old_exchange_to :exchange_to

  def exchange_to(other_currency, &rounding_method)
    value = old_exchange_to(other_currency, &rounding_method)
    Money.new(value.to_i, other_currency)
  end
end