class ProductLineItemOption < ActiveRecord::Base
  belongs_to :line_item
  belongs_to :standard_size
end
