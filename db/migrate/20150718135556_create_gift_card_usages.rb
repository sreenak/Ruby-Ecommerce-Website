class CreateGiftCardUsages < ActiveRecord::Migration
  def change
    create_table :gift_card_usages do |t|
      t.belongs_to :gift_card, index: true, foreign_key: true, on_delete: :cascade
      t.integer :amount_paisas, default: 0, null: false
      t.string :currency, default: '', null: false

      t.timestamps null: false
    end
  end
end
