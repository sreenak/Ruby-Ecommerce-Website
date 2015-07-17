class Dress < ActiveRecord::Base
  extend FriendlyId

  belongs_to :category
  has_many :part_groups

  validates_presence_of :name, :category, :sku, :base_price

  mount_uploader :angle_0, SvgUploader
  mount_uploader :angle_90, SvgUploader
  mount_uploader :angle_180, SvgUploader
  mount_uploader :angle_270, SvgUploader

  monetize :base_price_paisas
  friendly_id :name

  def should_generate_new_friendly_id?
    slug.blank? or name_changed?
  end
end
