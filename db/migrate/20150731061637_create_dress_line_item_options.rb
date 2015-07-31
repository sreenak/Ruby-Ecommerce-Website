class CreateDressLineItemOptions < ActiveRecord::Migration
  def change
    create_table :dress_line_item_options do |t|
      t.integer :line_item_id
      t.integer :dress_id
      t.integer :extended_size_id
      t.text :details, :limit => 64.megabytes

      t.timestamps null: false
    end
  end
end
