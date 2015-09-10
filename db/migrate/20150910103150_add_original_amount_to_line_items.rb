class AddOriginalAmountToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :original_amount, :integer
  end
end
