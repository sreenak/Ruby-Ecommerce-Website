class AddColumnSessionIdToCustomisedDresses < ActiveRecord::Migration
  def change
  	add_column :customised_dresses, :session_id, :integer
  end
end
