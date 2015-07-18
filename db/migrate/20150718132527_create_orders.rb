class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :status, limit: 2, default: 0, null: false
      t.integer :total_paisas, default: 0, null: false
      t.string :currency, default: 'INR', null: false

      t.timestamps null: false
    end
  end
end
