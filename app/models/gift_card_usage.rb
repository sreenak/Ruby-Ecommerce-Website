class GiftCardUsage < ActiveRecord::Base
  belongs_to :gift_card
  after_destroy :refill_gift_card

  validates_presence_of :gift_card_id, :amount

  monetize :amount_paisas, with_model_currency: :amount_currency

  def refill_gift_card
    gift_card.update remaining: gift_card.remaining + amount
  end
end
