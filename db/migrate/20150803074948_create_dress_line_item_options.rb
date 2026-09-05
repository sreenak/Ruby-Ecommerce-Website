class CreateDressLineItemOptions < ActiveRecord::Migration
    def change
      create_table :dress_line_item_options do |t|
        t.belongs_to :line_item, index: true, foreign_key: true
        t.belongs_to :standard_size, index: true, foreign_key: true
        t.string :details
        t.string :angle_0, null: false, default: ''
        t.string :angle_90
        t.string :angle_180
        t.string :angle_270
        t.timestamps null: false
      end
    end
  end
