class EmbellishmentPart < ActiveRecord::Base
  belongs_to :embellishment, dependent: :destroy
  belongs_to :part, dependent: :destroy

  validates_presence_of :embellishment, :image

  mount_uploader :image, ImageUploader
end
