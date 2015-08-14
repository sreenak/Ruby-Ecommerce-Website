class Product < ActiveRecord::Base
  extend FriendlyId

  belongs_to :category
  belongs_to :dress

  has_many :product_images, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_and_belongs_to_many :colors
  has_and_belongs_to_many :standard_sizes
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :product_images, allow_destroy: true

  validates_presence_of :name, :image, :price, :sku
  mount_uploader :image, ImageUploader

  monetize :price_paisas, with_model_currency: :currency

  friendly_id :name

  def should_generate_new_friendly_id?
    slug.blank? or name_changed?
  end

  default_scope -> {order(created_at: :desc)}
  scope :featured, -> {where(featured: true)}

end
