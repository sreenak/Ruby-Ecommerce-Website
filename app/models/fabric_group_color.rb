class FabricGroupColor < ActiveRecord::Base
  belongs_to :fabric_color
  belongs_to :fabric_parts_group
  has_and_belongs_to_many :embellishments
  monetize :price_paisas, with_model_currency: :currency
end