class BrocadePart < ActiveRecord::Base
  belongs_to :brocade
  belongs_to :part
  has_and_belongs_to_many :embellishments

  validates_presence_of :brocade, :image
  monetize :price_paisas, with_model_currency: :currency
  mount_uploader :image, ImageUploader
end
