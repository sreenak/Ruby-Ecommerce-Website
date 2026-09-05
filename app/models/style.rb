class Style < ActiveRecord::Base
  belongs_to :styles_group
  mount_uploader :image, ImageUploader
  validates_presence_of :name, :image
end
