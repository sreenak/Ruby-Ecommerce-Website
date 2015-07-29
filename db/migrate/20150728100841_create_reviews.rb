class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :product, index: true, null: :false
      t.belongs_to :user, index: true, null: :false
      t.string :name
      t.string :email
      t.string :message

      t.timestamps null: false
    end
    add_foreign_key :reviews, :products, dependent: :delete
    add_foreign_key :reviews, :users, dependent: :delete
  end
end
