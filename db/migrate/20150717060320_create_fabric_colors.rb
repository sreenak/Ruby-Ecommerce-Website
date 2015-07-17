class CreateFabricColors < ActiveRecord::Migration
  def change
    create_table :fabric_colors do |t|
      t.string :name, null: false, default: ''
      t.belongs_to :fabric, index: true, foreign_key: true
      t.string :swatch, null: false, default: ''

      t.timestamps null: false
    end
  end
end
