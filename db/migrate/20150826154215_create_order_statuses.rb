class CreateOrderStatuses < ActiveRecord::Migration
  def change
    create_table :order_statuses do |t|
      t.belongs_to :order, index: true, foreign_key: true
      t.column :status_type, "ENUM('schedule', 'reschedule', 'shipped')"
      t.date :date

      t.timestamps null: false
    end
  end
end
