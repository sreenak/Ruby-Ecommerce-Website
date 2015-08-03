class Embellishment < ActiveRecord::Base
  has_many :embellishment_parts, dependent: :destroy
  has_and_belongs_to_many :fabric_group_colors
  has_and_belongs_to_many :brocade_parts

  validates_presence_of :name, :image

  mount_uploader :image, ImageUploader
end
