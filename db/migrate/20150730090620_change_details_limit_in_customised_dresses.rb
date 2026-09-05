class ChangeDetailsLimitInCustomisedDresses < ActiveRecord::Migration
  def up
    change_column :customised_dresses, :details, :text, limit: 64.megabytes
  end

  def down
    change_column :customised_dresses, :details, :text, limit: 64.kilobytes
  end
end
