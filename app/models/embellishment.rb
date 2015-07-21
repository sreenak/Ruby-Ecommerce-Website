class Embellishment < ActiveRecord::Base
  has_many :embellishment_parts, dependent: :destroy

  validates_presence_of :name, :image

  mount_uploader :image, ImageUploader
end
