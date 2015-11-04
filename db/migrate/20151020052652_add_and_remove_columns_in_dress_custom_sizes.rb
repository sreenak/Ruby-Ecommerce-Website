class AddAndRemoveColumnsInDressCustomSizes < ActiveRecord::Migration
  def up
    add_column :dress_custom_sizes, :bust_chest, :integer
    add_column :dress_custom_sizes, :waist, :integer
    add_column :dress_custom_sizes, :waist_to_ankle, :integer
    add_column :dress_custom_sizes, :hips, :integer
    add_column :dress_custom_sizes, :shoulder, :integer
    add_column :dress_custom_sizes, :shoulder_to_neck, :integer
    add_column :dress_custom_sizes, :around_armpit, :integer
    add_column :dress_custom_sizes, :around_neck, :integer
    add_column :dress_custom_sizes, :sleev_length, :integer
    add_column :dress_custom_sizes, :line_item_id, :integer
    # remove_column :dress_custom_sizes, :size, :string
    # remove_column :dress_custom_sizes, :name, :string
    # remove_column :dress_custom_sizes, :unit, :string
  end

  def down
    remove_column :dress_custom_sizes, :bust_chest, :integer
    remove_column :dress_custom_sizes, :waist, :integer
    remove_column :dress_custom_sizes, :waist_to_ankle, :integer
    remove_column :dress_custom_sizes, :hips, :integer
    remove_column :dress_custom_sizes, :shoulder, :integer
    remove_column :dress_custom_sizes, :shoulder_to_neck, :integer
    remove_column :dress_custom_sizes, :around_armpit, :integer
    remove_column :dress_custom_sizes, :around_neck, :integer
    remove_column :dress_custom_sizes, :sleev_length, :integer
    remove_column :dress_custom_sizes, :line_item_id, :integer
    # add_column :dress_custom_sizes, :size, :string
    # add_column :dress_custom_sizes, :name, :string
    # add_column :dress_custom_sizes, :unit, :string
  end
end
