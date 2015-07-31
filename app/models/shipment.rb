class Shipment < ActiveRecord::Base
  STATUSES = ['Order Placed', 'In Transit', 'Delivered', 'Failed']

  # has_many :line_items
  enum status: STATUSES
  belongs_to :order
end
