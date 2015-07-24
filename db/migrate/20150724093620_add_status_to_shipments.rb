class AddStatusToShipments < ActiveRecord::Migration
  def change
    add_column :shipments, :status, :integer, limit: 2
  end
end
