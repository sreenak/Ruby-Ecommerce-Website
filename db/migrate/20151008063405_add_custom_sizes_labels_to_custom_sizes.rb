class AddCustomSizesLabelsToCustomSizes < ActiveRecord::Migration
  def up
      add_column :custom_sizes, :chest, :integer
      add_column :custom_sizes, :waist, :integer
      add_column :custom_sizes, :length, :integer
      add_column :custom_sizes, :shoulder, :integer
      add_column :custom_sizes, :arm_hole, :integer
      add_column :custom_sizes, :neck, :integer
      add_column :custom_sizes, :line_item_id, :integer
      add_column :custom_sizes, :line_item_id, :integer
      remove_column :custom_sizes, :size, :string
      remove_column :custom_sizes, :unit, :string
  end
  def down
    remove_column :custom_sizes, :chest, :integer
    remove_column :custom_sizes, :waist, :integer
    remove_column :custom_sizes, :length, :integer
    remove_column :custom_sizes, :shoulder, :integer
    remove_column :custom_sizes, :arm_hole, :integer
    remove_column :custom_sizes, :neck, :integer
    remove_column :custom_sizes, :line_item_id, :integer
    add_column :custom_sizes, :size, :string
    add_column :custom_sizes, :unit, :string
  end
end
