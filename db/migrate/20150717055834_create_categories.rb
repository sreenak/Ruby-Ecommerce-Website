class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ''
      t.string :slug, null: false, default: ''
      t.text :description

      t.timestamps null: false
    end
  end
end
