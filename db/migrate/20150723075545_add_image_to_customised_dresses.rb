class AddImageToCustomisedDresses < ActiveRecord::Migration
  def change
    add_column :customised_dresses, :image, :string
  end
end
