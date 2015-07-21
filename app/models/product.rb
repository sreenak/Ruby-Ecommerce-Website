class Product < ActiveRecord::Base
  extend FriendlyId

  belongs_to :dress
  has_many :product_images, dependent: :destroy
  has_many :likes
  accepts_nested_attributes_for :product_images, allow_destroy: true

  validates_presence_of :name, :image, :price, :sku
  mount_uploader :image, ImageUploader

  monetize :price_paisas, with_model_currency: :currency

  friendly_id :name

  def should_generate_new_friendly_id?
    slug.blank? or name_changed?
  end

  default_scope -> {order(created_at: :desc)}
end
