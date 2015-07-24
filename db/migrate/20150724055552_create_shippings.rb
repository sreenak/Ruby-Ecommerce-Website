class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.belongs_to :order, index: true
      t.string :tracking_id
      t.integer :status, limit: 2, default: 0, null: false

      t.timestamps null: false
    end
    add_foreign_key :shippings, :orders, on_delete: :cascade
  end
end
