class ProductLineItemOption < ActiveRecord::Base
  belongs_to :line_item
  belongs_to :standard_size
  validates_presence_of :standard_size_id
end
