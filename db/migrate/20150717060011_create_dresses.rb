class CreateDresses < ActiveRecord::Migration
  def change
    create_table :dresses do |t|
      t.string :name, null: false, default: ''
      t.string :slug, null: false, default: ''
      t.belongs_to :category, index: true, foreign_key: true
      t.string :sku, null: false, default: ''
      t.integer :base_price_paisas, null: false, default: 0
      t.string :currency, null: false, default: 'INR'
      t.string :angle_0, null: false, default: ''
      t.string :angle_90
      t.string :angle_180
      t.string :angle_270

      t.timestamps null: false
    end
  end
end
