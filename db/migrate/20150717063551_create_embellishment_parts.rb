class CreateEmbellishmentParts < ActiveRecord::Migration
  def change
    create_table :embellishment_parts do |t|
      t.belongs_to :embellishment, index: true, foreign_key: true
      t.belongs_to :part, index: true, foreign_key: true
      t.string :image, null: false, default: ''

      t.timestamps null: false
    end
  end
end
