class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :title, default: '', null: false
      t.belongs_to :order, index: true, foreign_key: true
      t.belongs_to :line_itemable, index: true, polymorphic: true
      t.integer :quantity, default: 0, null: false
      t.integer :amount_paisas, default: 0, null: false
      t.string :currency, default: 'INR', null: false

      t.timestamps null: false
    end
  end
end
