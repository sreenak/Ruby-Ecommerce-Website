class BrocadePart < ActiveRecord::Base
  belongs_to :brocade, dependent: :destroy
  belongs_to :part, dependent: :destroy

  validates_presence_of :brocade, :image

  mount_uploader :image, ImageUploader
end
