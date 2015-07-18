class Fabric < ActiveRecord::Base
  has_many :fabric_colors
  validates_presence_of :name

  accepts_nested_attributes_for :fabric_colors, allow_destroy: true
end
