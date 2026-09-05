class RemoveEmailFromGiftCards < ActiveRecord::Migration
  def change
    remove_column :gift_cards, :email, :string
  end
end
