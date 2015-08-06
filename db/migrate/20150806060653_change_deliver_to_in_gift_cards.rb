class ChangeDeliverToInGiftCards < ActiveRecord::Migration
  def up
    change_column :gift_cards, :deliver_to, :string
  end

  def down
    change_column :gift_cards, :deliver_to, :integer
  end
end
