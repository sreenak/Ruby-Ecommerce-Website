class RenameTrackingUrlToTrackingId < ActiveRecord::Migration
  def change
    change_table :shipments do |t|
      t.rename :tracking_url, :tracking_id
    end
  end
end
