class Brocade < ActiveRecord::Base
  has_many :brocade_parts, dependent: :destroy
  mount_uploader :swatch, ImageUploader

  validates_presence_of :name, :swatch
end
