class RenameOrderdToOrderedInGiftCards < ActiveRecord::Migration
  def change
    rename_column :gift_cards, :orderd_by, :ordered_by
  end
end
