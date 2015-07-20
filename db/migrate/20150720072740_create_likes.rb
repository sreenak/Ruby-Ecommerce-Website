class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :likes, :users, on_delete: :cascade
    add_foreign_key :likes, :products, on_delete: :cascade
  end
end
