class EmbellishmentPart < ActiveRecord::Base
  belongs_to :embellishment
  belongs_to :part

  validates_presence_of :embellishment, :image

  mount_uploader :image, ImageUploader
end
