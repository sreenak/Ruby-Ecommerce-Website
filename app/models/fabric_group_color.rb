class FabricGroupColor < ActiveRecord::Base
  belongs_to :fabric_color
  belongs_to :fabric_parts_group
  monetize :price_paisas, with_model_currency: :currency
end