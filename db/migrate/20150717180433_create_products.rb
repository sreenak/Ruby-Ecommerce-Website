class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false, default: ''
      t.string :slug, null: false, default: ''
      t.string :sku, null: false, default: ''
      t.integer :price_paisas, null: false, default: 0
      t.string :currency, null: false, default: 'INR'
      t.string :image, null: false, default: ''
      t.boolean :featured, null: false, default: 0
      t.belongs_to :dress, index: true, foreign_key: true
      t.text :description

      t.timestamps null: false
    end
  end
end
