class Dress < ActiveRecord::Base
  extend FriendlyId

  belongs_to :category
  has_many :parts_groups, dependent: :destroy
  has_many :embellishment_parts_groups, dependent: :destroy
  has_many :fabric_parts_groups, dependent: :destroy
  has_many :styles_groups, dependent: :destroy
  has_and_belongs_to_many :custom_sizes

  accepts_nested_attributes_for :embellishment_parts_groups, allow_destroy: true
  accepts_nested_attributes_for :fabric_parts_groups, allow_destroy: true
  accepts_nested_attributes_for :styles_groups, allow_destroy: true

  validates_presence_of :name, :category, :sku, :base_price, :sketch

  mount_uploader :sketch, ImageUploader
  mount_uploader :angle_0, SvgUploader
  mount_uploader :angle_90, SvgUploader
  mount_uploader :angle_180, SvgUploader
  mount_uploader :angle_270, SvgUploader

  monetize :base_price_paisas, with_model_currency: :currency
  friendly_id :name

  def should_generate_new_friendly_id?
    slug.blank? or name_changed?
  end
end
