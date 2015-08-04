class AddColumnTypeToGiftCards < ActiveRecord::Migration
  def change
    add_column :gift_cards, :type, :string
  end
end
