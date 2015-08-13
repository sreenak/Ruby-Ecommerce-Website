class DressLineItemOption < ActiveRecord::Base
  belongs_to :line_item
  belongs_to :standard_size
  mount_uploader :angle_0, ImageUploader
  mount_uploader :angle_90, ImageUploader
  mount_uploader :angle_180, ImageUploader
  mount_uploader :angle_270, ImageUploader
end
