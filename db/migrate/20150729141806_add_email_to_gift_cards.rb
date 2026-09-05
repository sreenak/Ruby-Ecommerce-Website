class AddEmailToGiftCards < ActiveRecord::Migration
  def change
    add_column :gift_cards, :email, :string, default: 0
  end
end
