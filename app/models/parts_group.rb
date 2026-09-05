class PartsGroup < ActiveRecord::Base
  belongs_to :dress
  has_many :parts, dependent: :destroy

  accepts_nested_attributes_for :parts, allow_destroy: true

  validates_presence_of :name, :svg_group_id
end
