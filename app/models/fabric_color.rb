class FabricColor < ActiveRecord::Base
  belongs_to :fabric
  has_many :fabric_group_colors
  has_and_belongs_to_many :parts_groups
  validates_presence_of :swatch
  mount_uploader :swatch, ImageUploader

  def label
    "#{fabric.name} - #{name}"
  end
end