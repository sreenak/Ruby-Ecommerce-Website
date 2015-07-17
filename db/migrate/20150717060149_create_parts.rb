class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name, null: false, default: ''
      t.belongs_to :part_group, index: true, foreign_key: true
      t.string :svg_path_id, null: false, default: ''

      t.timestamps null: false
    end
  end
end
