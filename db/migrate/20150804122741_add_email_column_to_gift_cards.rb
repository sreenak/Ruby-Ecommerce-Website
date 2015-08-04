class AddEmailColumnToGiftCards < ActiveRecord::Migration
  def change
    add_column :gift_cards, :email, :string
  end
end
