class EuCentralBank < Money::Bank::VariableExchange
  def calculate_exchange(from, to_currency, rate)
    to_currency_money = Money::Currency.wrap(to_currency).subunit_to_unit
    from_currency_money = from.currency.subunit_to_unit
    decimal_money = BigDecimal(to_currency_money) / BigDecimal(from_currency_money)
    Rails.logger.info "From #{from} to #{to_currency}"
    money = to_currency == 'USD' ? ((decimal_money * from.cents * rate)/100).ceil * 100 : (decimal_money * from.cents * rate).round
    Money.new(money, to_currency)
  end
end