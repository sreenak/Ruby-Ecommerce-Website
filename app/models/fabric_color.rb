class FabricColor < ActiveRecord::Base
  belongs_to :fabric
  has_and_belongs_to_many :part_groups
  validates_presence_of :fabric, :swatch
  mount_uploader :swatch, ImageUploader
end
