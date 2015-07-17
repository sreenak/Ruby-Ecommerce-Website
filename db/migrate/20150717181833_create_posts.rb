class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ''
      t.string :slug, null: false, default: ''
      t.string :image, null: false, default: ''
      t.text :body
      t.boolean :featured, null: false, default: 0

      t.timestamps null: false
    end
  end
end
