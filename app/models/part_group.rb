class PartGroup < ActiveRecord::Base
  belongs_to :dress
  has_many :parts

  validates_presence_of :dress, :svg_group_id
end
