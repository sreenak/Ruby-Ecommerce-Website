class Part < ActiveRecord::Base
  belongs_to :part_group
  has_many :brocade_parts
  has_many :embellishment_parts

  validates_presence_of :part_group, :name, :svg_path_id
end
