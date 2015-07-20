class Part < ActiveRecord::Base
  belongs_to :parts_group
  has_many :brocade_parts
  has_many :embellishment_parts

  accepts_nested_attributes_for :brocade_parts, allow_destroy: true
  accepts_nested_attributes_for :embellishment_parts, allow_destroy: true

  validates_presence_of :name, :svg_path_id
end
