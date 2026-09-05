class CreateBrocadeParts < ActiveRecord::Migration
  def change
    create_table :brocade_parts do |t|
      t.belongs_to :brocade, index: true, foreign_key: true
      t.belongs_to :part, index: true, foreign_key: true
      t.string :image, null: false, default: ''

      t.timestamps null: false
    end
  end
end
