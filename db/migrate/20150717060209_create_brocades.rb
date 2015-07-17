class CreateBrocades < ActiveRecord::Migration
  def change
    create_table :brocades do |t|
      t.string :name, null: false, default: ''
      t.string :swatch, null: false, default: ''

      t.timestamps null: false
    end
  end
end
