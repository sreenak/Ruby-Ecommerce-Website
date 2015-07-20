class BrocadePart < ActiveRecord::Base
  belongs_to :brocade
  belongs_to :part

  validates_presence_of :brocade, :image

  mount_uploader :image, ImageUploader
end
