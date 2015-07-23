class StylesGroup < PartsGroup
  has_many :styles
  accepts_nested_attributes_for :styles, allow_destroy: true
end