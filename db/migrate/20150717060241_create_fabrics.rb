class CreateFabrics < ActiveRecord::Migration
  def change
    create_table :fabrics do |t|
      t.string :name, null: false, default: ''

      t.timestamps null: false
    end
  end
end
