class FabricColor < ActiveRecord::Base
  belongs_to :fabric, dependent: :destroy
  has_and_belongs_to_many :parts_groups
  validates_presence_of :swatch
  mount_uploader :swatch, ImageUploader

  def label
    "#{fabric.name} - #{name}"
  end
end