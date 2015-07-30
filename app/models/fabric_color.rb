class FabricColor < ActiveRecord::Base
  belongs_to :fabric
  has_many :fabric_group_colors, dependent: :destroy
  validates_presence_of :swatch
  mount_uploader :swatch, ImageUploader

  def label
    "#{fabric.name} - #{name}"
  end
end