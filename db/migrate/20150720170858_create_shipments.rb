class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.belongs_to :order, index: true, foreign_key: true
      t.string :tracking_url

      t.timestamps null: false
    end
  end
end
