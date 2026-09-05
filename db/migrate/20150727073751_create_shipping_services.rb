class CreateShippingServices < ActiveRecord::Migration
  def change
    create_table :shipping_services do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
