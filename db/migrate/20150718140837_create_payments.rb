class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :order, index: true, foreign_key: true
      t.string :method
      t.integer :amount_paisas
      t.string :currency

      t.timestamps null: false
    end
  end
end
