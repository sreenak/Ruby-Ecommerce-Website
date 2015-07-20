class CreatePartGroups < ActiveRecord::Migration
  def change
    create_table :parts_groups do |t|
      t.string :name, null: false, default: ''
      t.belongs_to :dress, index: true, foreign_key: true
      t.string :type, null: false, default: ''
      t.string :svg_group_id, null: false, default: ''

      t.timestamps null: false
    end
  end
end
