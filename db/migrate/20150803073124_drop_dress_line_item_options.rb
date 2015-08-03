class DropDressLineItemOptions < ActiveRecord::Migration
  def change
    drop_table :dress_line_item_options
  end
end
