class FabricPartsGroup < PartsGroup
  has_many :fabric_group_colors
  has_many :fabric_colors, through: :fabric_group_colors
  accepts_nested_attributes_for :fabric_group_colors, allow_destroy: true
end