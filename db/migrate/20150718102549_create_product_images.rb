class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.belongs_to :product, index: true, foreign_key: true, on_delete: :cascade
      t.string :image, null: false, default: ''

      t.timestamps null: false
    end
  end
end
