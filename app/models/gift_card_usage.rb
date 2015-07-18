class GiftCardUsage < ActiveRecord::Base
  belongs_to :gift_card

  validates_presence_of :gift_card_id, :amount

  monetize :amount_paisas, with_model_currency: :amount_currency
end
