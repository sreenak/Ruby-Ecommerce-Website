class CreateCustomSizes < ActiveRecord::Migration
  def change
    create_table :custom_sizes do |t|
      t.string :name
      t.string :size
      t.string :unit

      t.timestamps null: false
    end
  end
end
