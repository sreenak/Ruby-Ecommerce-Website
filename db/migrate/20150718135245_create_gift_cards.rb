class CreateGiftCards < ActiveRecord::Migration
  def change
    create_table :gift_cards do |t|
      t.string :code, default: '', null: false
      t.integer :status, limit: 2
      t.string :orderd_by, default: '', null: false
      t.string :ordered_for, default: '', null: false
      t.text :message
      t.integer :amount_paisas, default: 0, null: false
      t.integer :remaining_paisas, default: 0, null: false
      t.string :currency, default: 'INR', null: false
      t.string :deliver_to, default: '', null: false
      t.string :card_type, default: '', null: false

      t.timestamps null: false
    end
  end
end
