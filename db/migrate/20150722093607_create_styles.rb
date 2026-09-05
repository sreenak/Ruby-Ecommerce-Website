class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.belongs_to :styles_group, index: true
      t.string :name
      t.string :image
      t.string :svg_path_id

      t.timestamps null: false
    end
  end
end
