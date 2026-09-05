class RemoveCardTypeFromGiftCards < ActiveRecord::Migration
  def change
    remove_column :gift_cards, :card_type, :string
  end
end
