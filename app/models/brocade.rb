class Brocade < ActiveRecord::Base
  has_many :brocade_parts
  mount_uploader :swatch, ImageUploader

  validates_presence_of :name, :swatch
end
