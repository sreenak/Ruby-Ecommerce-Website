class CreateEmbellishments < ActiveRecord::Migration
  def change
    create_table :embellishments do |t|
      t.string :name, null: false, default: ''
      t.string :image, null: false, default: ''

      t.timestamps null: false
    end
  end
end
