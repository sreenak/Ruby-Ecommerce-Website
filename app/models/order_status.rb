class OrderStatus < ActiveRecord::Base
  STATUSES = ['schedule', 'reschedule', 'shipped']
  belongs_to :order
end
