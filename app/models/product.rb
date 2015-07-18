class Product < ActiveRecord::Base
  extend FriendlyId

  belongs_to :dress

  validates_presence_of :name, :image, :price, :sku
  mount_uploader :image, ImageUploader

  monetize :price_paisas, with_model_currency: :currency

  friendly_id :name

  def should_generate_new_friendly_id?
    slug.blank? or name_changed?
  end
end
