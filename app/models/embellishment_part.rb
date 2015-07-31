class EmbellishmentPart < ActiveRecord::Base
  belongs_to :embellishment
  belongs_to :part
  monetize :price_paisas, with_model_currency: :currency
  validates_presence_of :embellishment, :image

  mount_uploader :image, ImageUploader
end
