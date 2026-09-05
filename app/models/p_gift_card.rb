class PGiftCard < GiftCard
  has_one :shipping_address, as: :addressable
  accepts_nested_attributes_for :shipping_address, reject_if: :shipping_not_required?

  private
  def shipping_not_required?
    self.deliver_to == 'Me'
  end
end
