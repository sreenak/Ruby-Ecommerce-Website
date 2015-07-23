class CreateCustomisedDresses < ActiveRecord::Migration
  def change
    create_table :customised_dresses do |t|
      t.belongs_to :user, index: true, null: :false
      t.belongs_to :dress, index: true, null: :false
      t.text :details

      t.timestamps null: false
    end
    add_foreign_key :customised_dresses, :users, dependent: :delete
    add_foreign_key :customised_dresses, :dresses, dependent: :delete
  end
end
