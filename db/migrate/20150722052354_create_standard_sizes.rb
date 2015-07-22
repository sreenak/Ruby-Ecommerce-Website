class CreateStandardSizes < ActiveRecord::Migration
  def change
    create_table :standard_sizes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
