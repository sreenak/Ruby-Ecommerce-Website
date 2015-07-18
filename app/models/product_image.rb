class ProductImage < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :image

  mount_uploader :image, ImageUploader
end
